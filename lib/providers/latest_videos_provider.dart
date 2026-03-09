import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/video.dart';
import '../models/channel.dart';
import '../services/rss_service.dart';
import '../services/database_service.dart';
import 'channels_provider.dart';
import 'settings_provider.dart';

final rssServiceProvider = Provider<RssService>((ref) {
  return RssService();
});

final latestVideosProvider =
    StateNotifierProvider<LatestVideosNotifier, LatestVideosState>((ref) {
  return LatestVideosNotifier(
    ref,
    ref.read(rssServiceProvider),
    ref.read(databaseServiceProvider),
  );
});

class LatestVideosState {
  final List<Video> allVideos; // 전체 영상
  final bool isLoading; // 초기 로딩
  final bool isLoadingMore; // 추가 로딩 (무한 스크롤)
  final String? errorMessage;
  final DateTime? lastUpdated;
  final String? selectedCollectionId; // 선택된 컬렉션
  final Set<String> collectionChannelIds; // 컬렉션에 속한 채널 ID들
  final int loadedChannelCount; // 로드된 채널 수
  final int totalChannelCount; // 전체 채널 수
  final bool hasMore; // 더 로드할 채널이 있는지

  LatestVideosState({
    this.allVideos = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.lastUpdated,
    this.selectedCollectionId,
    this.collectionChannelIds = const {},
    this.loadedChannelCount = 0,
    this.totalChannelCount = 0,
    this.hasMore = true,
  });

  // 현재 표시할 영상 (컬렉션 필터 적용)
  List<Video> get videos {
    if (selectedCollectionId == null || selectedCollectionId == 'all') {
      return allVideos;
    }
    return allVideos
        .where((video) => collectionChannelIds.contains(video.channelId))
        .toList();
  }

  LatestVideosState copyWith({
    List<Video>? allVideos,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    DateTime? lastUpdated,
    String? selectedCollectionId,
    bool? resetCollectionId,
    Set<String>? collectionChannelIds,
    int? loadedChannelCount,
    int? totalChannelCount,
    bool? hasMore,
  }) {
    return LatestVideosState(
      allVideos: allVideos ?? this.allVideos,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      selectedCollectionId: resetCollectionId == true
          ? null
          : (selectedCollectionId ?? this.selectedCollectionId),
      collectionChannelIds: collectionChannelIds ?? this.collectionChannelIds,
      loadedChannelCount: loadedChannelCount ?? this.loadedChannelCount,
      totalChannelCount: totalChannelCount ?? this.totalChannelCount,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class LatestVideosNotifier extends StateNotifier<LatestVideosState> {
  final Ref _ref;
  final RssService _rssService;
  final DatabaseService _db;

  // 페이지네이션을 위한 채널 목록 캐시
  List<MapEntry<String, String>> _allChannels = [];
  static const int _channelsPerBatch = 10; // 한 번에 로드할 채널 수

  LatestVideosNotifier(this._ref, this._rssService, this._db)
      : super(LatestVideosState());

  /// RSS 피드로 최신 영상 가져오기 (첫 배치)
  Future<void> fetchLatestVideos() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // 설정에서 채널당 영상 개수 가져오기 (로딩 완료 대기)
      final maxResults = await _ref.read(videosPerChannelProvider.notifier).ensureLoaded();

      // 모든 채널 목록 가져오기 (구독 여부와 관계없이)
      final List<Channel> channels = await _db.getAllChannelsIncludingUnsubscribed();
      _allChannels = channels.map((c) => MapEntry(c.id, c.title)).toList();

      // 첫 배치 채널 가져오기
      final firstBatchChannels = _allChannels.take(_channelsPerBatch).toList();

      // RSS 피드로 영상 가져오기
      final videos = await _rssService.fetchLatestVideosFromChannels(
        firstBatchChannels,
        maxResults: maxResults,
      );

      state = state.copyWith(
        allVideos: videos,
        isLoading: false,
        lastUpdated: DateTime.now(),
        loadedChannelCount: firstBatchChannels.length,
        totalChannelCount: _allChannels.length,
        hasMore: firstBatchChannels.length < _allChannels.length,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 다음 배치 로드 (무한 스크롤)
  Future<void> loadMore() async {
    // 이미 로딩 중이거나 더 이상 로드할 것이 없으면 무시
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final maxResults = await _ref.read(videosPerChannelProvider.notifier).ensureLoaded();

      // 다음 배치 채널 가져오기
      final startIndex = state.loadedChannelCount;
      final endIndex = (startIndex + _channelsPerBatch).clamp(0, _allChannels.length);
      final nextBatchChannels = _allChannels.sublist(startIndex, endIndex);

      if (nextBatchChannels.isEmpty) {
        state = state.copyWith(isLoadingMore: false, hasMore: false);
        return;
      }

      // RSS 피드로 영상 가져오기
      final newVideos = await _rssService.fetchLatestVideosFromChannels(
        nextBatchChannels,
        maxResults: maxResults,
      );

      // 기존 영상과 합치고 날짜순 정렬
      final allVideos = [...state.allVideos, ...newVideos];
      allVideos.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

      state = state.copyWith(
        allVideos: allVideos,
        isLoadingMore: false,
        loadedChannelCount: endIndex,
        hasMore: endIndex < _allChannels.length,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 컬렉션 선택
  Future<void> setSelectedCollection(String? collectionId) async {
    if (collectionId == null || collectionId == 'all') {
      state = state.copyWith(
        resetCollectionId: true,
        collectionChannelIds: {},
      );
    } else {
      // 컬렉션에 속한 채널 ID 가져오기
      final channels = await _db.getChannelsInCollection(collectionId);
      final channelIds = channels.map((c) => c.id).toSet();

      state = state.copyWith(
        selectedCollectionId: collectionId,
        collectionChannelIds: channelIds,
      );

      // 이미 로드된 채널 ID 확인
      final loadedChannelIds = _allChannels
          .take(state.loadedChannelCount)
          .map((e) => e.key)
          .toSet();

      // 컬렉션 채널 중 로드되지 않은 채널 확인
      final unloadedChannelIds = channelIds.difference(loadedChannelIds);

      // 로드되지 않은 채널이 있으면 해당 채널들의 영상 가져오기
      if (unloadedChannelIds.isNotEmpty) {
        await _loadChannelsForCollection(unloadedChannelIds);
      }
    }
  }

  /// 특정 채널들의 영상만 로드 (컬렉션 선택 시)
  Future<void> _loadChannelsForCollection(Set<String> channelIds) async {
    // 초기 로딩 중이면 무시 (isLoadingMore는 무시하지 않음 - 스와이프로 빠르게 컬렉션 변경 시 로드 가능하도록)
    if (state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final maxResults = await _ref.read(videosPerChannelProvider.notifier).ensureLoaded();

      // 해당 채널 ID에 맞는 채널 정보 가져오기
      final channelsToLoad = _allChannels
          .where((e) => channelIds.contains(e.key))
          .toList();

      if (channelsToLoad.isEmpty) {
        state = state.copyWith(isLoadingMore: false);
        return;
      }

      // RSS 피드로 영상 가져오기
      final newVideos = await _rssService.fetchLatestVideosFromChannels(
        channelsToLoad,
        maxResults: maxResults,
      );

      // 기존 영상과 합치고 중복 제거 후 날짜순 정렬
      final existingVideoIds = state.allVideos.map((v) => v.id).toSet();
      final uniqueNewVideos = newVideos.where((v) => !existingVideoIds.contains(v.id)).toList();

      final allVideos = [...state.allVideos, ...uniqueNewVideos];
      allVideos.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

      state = state.copyWith(
        allVideos: allVideos,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 새로고침 (전체 다시 로드)
  Future<void> refresh() async {
    // 현재 선택된 컬렉션 ID 저장
    final currentCollectionId = state.selectedCollectionId;
    final currentCollectionChannelIds = state.collectionChannelIds;

    _allChannels = []; // 채널 목록 초기화
    await fetchLatestVideos();

    // 선택된 컬렉션이 있으면 해당 컬렉션 채널도 로드
    if (currentCollectionId != null && currentCollectionId != 'all' && currentCollectionChannelIds.isNotEmpty) {
      // 컬렉션 상태 복원
      state = state.copyWith(
        selectedCollectionId: currentCollectionId,
        collectionChannelIds: currentCollectionChannelIds,
      );

      // 로드된 채널 ID 확인
      final loadedChannelIds = _allChannels
          .take(state.loadedChannelCount)
          .map((e) => e.key)
          .toSet();

      // 컬렉션 채널 중 로드되지 않은 채널 확인
      final unloadedChannelIds = currentCollectionChannelIds.difference(loadedChannelIds);

      // 로드되지 않은 채널이 있으면 해당 채널들의 영상 가져오기
      if (unloadedChannelIds.isNotEmpty) {
        await _loadChannelsForCollection(unloadedChannelIds);
      }
    }
  }

  /// 상태 초기화
  void clear() {
    _allChannels = [];
    state = LatestVideosState();
  }
}
