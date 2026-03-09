import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/channel.dart';
import '../services/database_service.dart';
import '../services/youtube_service.dart';
import '../services/storage_service.dart';
import 'auth_provider.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

final channelsProvider =
    StateNotifierProvider<ChannelsNotifier, ChannelsState>((ref) {
  return ChannelsNotifier(
    ref.read(databaseServiceProvider),
    ref.read(youtubeServiceProvider),
    ref.read(storageServiceProvider),
    ref.read(authStateProvider.notifier),
  );
});

class ChannelsState {
  final List<Channel> channels;
  final bool isLoading;
  final String? errorMessage;
  final String? selectedCollectionId;
  final bool isSortedAlphabetically;

  ChannelsState({
    this.channels = const [],
    this.isLoading = false,
    this.errorMessage,
    this.selectedCollectionId,
    this.isSortedAlphabetically = false,
  });

  ChannelsState copyWith({
    List<Channel>? channels,
    bool? isLoading,
    String? errorMessage,
    String? selectedCollectionId,
    bool? resetCollectionId,
    bool? isSortedAlphabetically,
  }) {
    return ChannelsState(
      channels: channels ?? this.channels,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      selectedCollectionId: resetCollectionId == true
          ? null
          : (selectedCollectionId ?? this.selectedCollectionId),
      isSortedAlphabetically:
          isSortedAlphabetically ?? this.isSortedAlphabetically,
    );
  }

  List<Channel> get displayedChannels {
    if (selectedCollectionId == null || selectedCollectionId == 'all') {
      return channels;
    }
    // 컬렉션 필터링은 별도로 처리
    return channels;
  }
}

class ChannelsNotifier extends StateNotifier<ChannelsState> {
  final DatabaseService _db;
  final YouTubeService _youtube;
  final StorageService _storage;
  final AuthNotifier _authNotifier;

  ChannelsNotifier(this._db, this._youtube, this._storage, this._authNotifier)
      : super(ChannelsState());

  /// 토큰 관련 에러인지 확인
  bool _isTokenError(String error) {
    return error.contains('invalid_token') ||
           error.contains('Token') ||
           error.contains('401') ||
           error.contains('Unauthorized');
  }

  /// 로컬 DB에서 채널 로드
  Future<void> loadChannels() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final channels = await _db.getAllChannels();
      state = state.copyWith(
        channels: channels,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 컬렉션의 채널 로드
  Future<void> loadChannelsInCollection(String collectionId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final channels = await _db.getChannelsInCollection(collectionId);
      state = state.copyWith(
        channels: channels,
        isLoading: false,
        selectedCollectionId: collectionId,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// YouTube API에서 구독 채널 가져오기 (초기 로드)
  Future<void> fetchSubscriptionsFromYouTube({bool isRetry = false}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final channels = await _youtube.fetchSubscriptions();

      await _db.insertChannels(channels);

      await _storage.setLastSyncTime(DateTime.now());

      state = state.copyWith(
        channels: channels,
        isLoading: false,
      );
    } catch (e) {
      // 토큰 에러인 경우 갱신 후 재시도 (1회만)
      if (!isRetry && _isTokenError(e.toString())) {
        final refreshed = await _authNotifier.refreshTokenAndUpdateClient();
        if (refreshed) {
          return fetchSubscriptionsFromYouTube(isRetry: true);
        }
      }
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// YouTube API에서 구독 변경사항 확인 (증분 업데이트)
  Future<void> refreshSubscriptions({bool isRetry = false}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final existingChannels = await _db.getAllChannels();
      final existingIds = existingChannels.map((c) => c.id).toList();

      final diff = await _youtube.checkSubscriptionChanges(existingIds);

      // 신규 채널 추가
      if (diff.newChannels.isNotEmpty) {
        await _db.insertChannels(diff.newChannels);
      }

      // 구독 취소된 채널의 is_subscribed를 0으로 업데이트
      for (final id in diff.deletedChannelIds) {
        await _db.updateChannelSubscriptionStatus(id, false);
      }

      await _storage.setLastSyncTime(DateTime.now());

      // 업데이트된 채널 목록 로드
      final updatedChannels = await _db.getAllChannels();
      state = state.copyWith(
        channels: updatedChannels,
        isLoading: false,
      );
    } catch (e) {
      // 토큰 에러인 경우 갱신 후 재시도 (1회만)
      if (!isRetry && _isTokenError(e.toString())) {
        final refreshed = await _authNotifier.refreshTokenAndUpdateClient();
        if (refreshed) {
          return refreshSubscriptions(isRetry: true);
        }
      }
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      rethrow; // 에러를 다시 throw해서 호출자가 처리할 수 있도록
    }
  }

  /// 채널 순서 업데이트
  Future<void> reorderChannels(int oldIndex, int newIndex) async {
    final channels = List<Channel>.from(state.channels);

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final channel = channels.removeAt(oldIndex);
    channels.insert(newIndex, channel);

    // 즉시 UI 업데이트 (수동 정렬 시 가나다순 모드 해제)
    state = state.copyWith(
      channels: channels,
      isSortedAlphabetically: false,
    );

    // DB 업데이트
    try {
      if (state.selectedCollectionId == null ||
          state.selectedCollectionId == 'all') {
        // 전체 보기 모드 - channels.sort_order 업데이트
        await _db.updateChannelsSortOrder(channels);
      } else {
        // 컬렉션 모드 - collection_orders.sort_order 업데이트
        await _db.updateCollectionChannelOrder(
          state.selectedCollectionId!,
          channels,
        );
      }
    } catch (e) {
      // DB 업데이트 실패 시 원래 상태로 복구
      await loadChannels();
    }
  }

  /// 채널을 컬렉션에 추가
  Future<void> addToCollection(String channelId, String collectionId) async {
    try {
      await _db.addChannelToCollection(channelId, collectionId);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// 채널을 컬렉션에서 제거
  Future<void> removeFromCollection(
      String channelId, String collectionId) async {
    try {
      await _db.removeChannelFromCollection(channelId, collectionId);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// 채널 삭제 (구독 취소)
  Future<void> deleteChannel(String channelId) async {
    try {
      await _db.deleteChannel(channelId);
      final channels =
          state.channels.where((c) => c.id != channelId).toList();
      state = state.copyWith(channels: channels);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// 필터 변경
  void setSelectedCollection(String? collectionId) {
    if (collectionId == null) {
      state = state.copyWith(resetCollectionId: true);
      loadChannels();
    } else {
      state = state.copyWith(selectedCollectionId: collectionId);
      if (collectionId == 'all') {
        loadChannels();
      } else {
        loadChannelsInCollection(collectionId);
      }
    }
  }

  /// 정렬 모드 토글
  Future<void> toggleSortMode() async {
    final newSortMode = !state.isSortedAlphabetically;

    if (newSortMode) {
      // 가나다순 정렬
      final sortedChannels = List<Channel>.from(state.channels)
        ..sort((a, b) => a.title.compareTo(b.title));

      state = state.copyWith(
        channels: sortedChannels,
        isSortedAlphabetically: true,
      );
    } else {
      // 사용자 지정 순서로 복원 - DB에서 다시 로드
      state = state.copyWith(isSortedAlphabetically: false);

      if (state.selectedCollectionId == null || state.selectedCollectionId == 'all') {
        await loadChannels();
      } else {
        await loadChannelsInCollection(state.selectedCollectionId!);
      }
    }
  }

  /// 상태 초기화 (로그아웃 시)
  void clear() {
    state = ChannelsState();
  }
}

/// 채널 ID -> 썸네일 URL 매핑 Provider
final channelThumbnailsProvider = FutureProvider<Map<String, String>>((ref) async {
  final db = ref.read(databaseServiceProvider);
  final channels = await db.getAllChannels();

  return {
    for (final channel in channels)
      if (channel.thumbnailUrl != null) channel.id: channel.thumbnailUrl!
  };
});
