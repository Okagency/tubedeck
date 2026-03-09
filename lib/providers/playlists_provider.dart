import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/playlist.dart';
import '../models/video.dart';
import '../services/youtube_service.dart';
import '../services/database_service.dart';
import 'auth_provider.dart';
import 'channels_provider.dart';

/// 정렬 모드
enum PlaylistSortMode {
  custom,    // 사용자 정의 순서
  alphabetical, // 가나다 순
}

final playlistsProvider =
    StateNotifierProvider<PlaylistsNotifier, PlaylistsState>((ref) {
  return PlaylistsNotifier(
    ref.read(youtubeServiceProvider),
    ref.read(databaseServiceProvider),
    ref.read(authStateProvider.notifier),
  );
});

class PlaylistsState {
  final List<Playlist> playlists;
  final List<Video> playlistVideos;
  final bool isLoading;
  final bool isLoadingVideos;
  final String? errorMessage;
  final String? selectedPlaylistId;
  final PlaylistSortMode sortMode;

  PlaylistsState({
    this.playlists = const [],
    this.playlistVideos = const [],
    this.isLoading = false,
    this.isLoadingVideos = false,
    this.errorMessage,
    this.selectedPlaylistId,
    this.sortMode = PlaylistSortMode.custom,
  });

  PlaylistsState copyWith({
    List<Playlist>? playlists,
    List<Video>? playlistVideos,
    bool? isLoading,
    bool? isLoadingVideos,
    String? errorMessage,
    String? selectedPlaylistId,
    bool? clearError,
    bool? clearSelectedPlaylist,
    PlaylistSortMode? sortMode,
  }) {
    return PlaylistsState(
      playlists: playlists ?? this.playlists,
      playlistVideos: playlistVideos ?? this.playlistVideos,
      isLoading: isLoading ?? this.isLoading,
      isLoadingVideos: isLoadingVideos ?? this.isLoadingVideos,
      errorMessage: clearError == true ? null : (errorMessage ?? this.errorMessage),
      selectedPlaylistId: clearSelectedPlaylist == true ? null : (selectedPlaylistId ?? this.selectedPlaylistId),
      sortMode: sortMode ?? this.sortMode,
    );
  }
}

class PlaylistsNotifier extends StateNotifier<PlaylistsState> {
  final YouTubeService _youtube;
  final DatabaseService _db;
  final AuthNotifier _authNotifier;

  PlaylistsNotifier(this._youtube, this._db, this._authNotifier) : super(PlaylistsState());

  /// 캐시된 재생목록 로드
  Future<void> loadCachedPlaylists() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final playlists = await _db.getCachedPlaylists();

      if (playlists.isEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }

      // DB에서 정렬 순서 가져오기
      final orders = await _db.getPlaylistOrders();

      // 정렬 적용
      final sortedPlaylists = _sortPlaylists(playlists, orders, state.sortMode);

      state = state.copyWith(
        playlists: sortedPlaylists,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 재생목록 가져오기 (YouTube API)
  Future<void> fetchPlaylists({bool isRetry = false}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final playlists = await _youtube.fetchPlaylists();

      // 캐시에 저장
      await _db.cachePlaylists(playlists);

      // DB에서 정렬 순서 가져오기
      final orders = await _db.getPlaylistOrders();

      // 삭제된 재생목록 정렬 데이터 정리
      final validIds = playlists.map((p) => p.id).toList();
      await _db.cleanupPlaylistOrders(validIds);

      // 정렬 적용
      final sortedPlaylists = _sortPlaylists(playlists, orders, state.sortMode);

      state = state.copyWith(
        playlists: sortedPlaylists,
        isLoading: false,
      );
    } catch (e) {
      // 404 에러는 재생목록이 없는 경우 - 에러가 아님
      if (_isNotFoundError(e.toString())) {
        state = state.copyWith(
          playlists: [],
          isLoading: false,
        );
        return;
      }

      // 토큰 에러인 경우 갱신 후 재시도 (1회만)
      if (!isRetry && _isTokenError(e.toString())) {
        final refreshed = await _authNotifier.refreshTokenAndUpdateClient();
        if (refreshed) {
          return fetchPlaylists(isRetry: true);
        }
      }
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 토큰 관련 에러인지 확인
  bool _isTokenError(String error) {
    return error.contains('invalid_token') ||
           error.contains('Token') ||
           error.contains('401') ||
           error.contains('Unauthorized');
  }

  /// 404 에러인지 확인 (재생목록이 없는 경우)
  bool _isNotFoundError(String error) {
    return error.contains('404') ||
           error.contains('Channel not found') ||
           error.contains('Not Found');
  }

  /// 재생목록의 영상 가져오기
  Future<void> fetchPlaylistVideos(String playlistId, {bool isRetry = false}) async {
    state = state.copyWith(
      isLoadingVideos: true,
      selectedPlaylistId: playlistId,
      clearError: true,
    );

    try {
      final videos = await _youtube.fetchPlaylistVideos(playlistId);
      state = state.copyWith(
        playlistVideos: videos,
        isLoadingVideos: false,
      );
    } catch (e) {
      // 토큰 에러인 경우 갱신 후 재시도 (1회만)
      if (!isRetry && _isTokenError(e.toString())) {
        final refreshed = await _authNotifier.refreshTokenAndUpdateClient();
        if (refreshed) {
          return fetchPlaylistVideos(playlistId, isRetry: true);
        }
      }
      state = state.copyWith(
        isLoadingVideos: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 재생목록 선택 해제
  void clearSelectedPlaylist() {
    state = state.copyWith(
      playlistVideos: [],
      clearSelectedPlaylist: true,
      clearError: true,
    );
  }

  /// 정렬 모드 변경
  Future<void> toggleSortMode() async {
    final newMode = state.sortMode == PlaylistSortMode.custom
        ? PlaylistSortMode.alphabetical
        : PlaylistSortMode.custom;

    final orders = await _db.getPlaylistOrders();
    final sortedPlaylists = _sortPlaylists(state.playlists, orders, newMode);

    state = state.copyWith(
      sortMode: newMode,
      playlists: sortedPlaylists,
    );
  }

  /// 재생목록 순서 변경 (드래그앤드롭)
  Future<void> reorderPlaylist(int oldIndex, int newIndex) async {
    if (state.sortMode != PlaylistSortMode.custom) return;

    final playlists = List<Playlist>.from(state.playlists);
    final item = playlists.removeAt(oldIndex);
    playlists.insert(newIndex, item);

    // 새 순서 저장
    final orders = <String, int>{};
    for (int i = 0; i < playlists.length; i++) {
      orders[playlists[i].id] = i;
    }
    await _db.savePlaylistOrders(orders);

    state = state.copyWith(playlists: playlists);
  }

  /// 재생목록 정렬
  List<Playlist> _sortPlaylists(
    List<Playlist> playlists,
    Map<String, int> orders,
    PlaylistSortMode mode,
  ) {
    final sorted = List<Playlist>.from(playlists);

    if (mode == PlaylistSortMode.alphabetical) {
      // 가나다 순
      sorted.sort((a, b) => a.title.compareTo(b.title));
    } else {
      // 사용자 정의 순서
      sorted.sort((a, b) {
        final orderA = orders[a.id] ?? 9999;
        final orderB = orders[b.id] ?? 9999;
        if (orderA != orderB) {
          return orderA.compareTo(orderB);
        }
        // 순서가 없으면 제목순
        return a.title.compareTo(b.title);
      });
    }

    return sorted;
  }

  /// 상태 초기화
  void clear() {
    state = PlaylistsState();
  }

  /// 상태 및 캐시 초기화
  Future<void> clearWithCache() async {
    state = PlaylistsState();
    await _db.clearPlaylistsCache();
  }
}
