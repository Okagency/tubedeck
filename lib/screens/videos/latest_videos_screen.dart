import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/latest_videos_provider.dart';
import '../../providers/collections_provider.dart';
import '../../providers/channels_provider.dart';
import '../../models/video.dart';
import '../../models/collection.dart';
import '../../widgets/collection_chip.dart';
import '../../utils/constants.dart';
import '../../providers/settings_provider.dart';
import '../../providers/favorites_provider.dart';
import '../../l10n/app_localizations.dart';

class LatestVideosScreen extends ConsumerStatefulWidget {
  const LatestVideosScreen({super.key});

  @override
  ConsumerState<LatestVideosScreen> createState() => _LatestVideosScreenState();
}

class _LatestVideosScreenState extends ConsumerState<LatestVideosScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final Map<String, Set<String>> _collectionChannelIds = {};
  final ScrollController _chipScrollController = ScrollController();
  final ScrollController _listScrollController = ScrollController();
  final Map<String, double> _scrollPositions = {}; // 폴더별 스크롤 위치 저장

  // 폴더 전환 슬라이드 애니메이션
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  bool get wantKeepAlive => true;

  /// 폴더 전환 슬라이드 애니메이션 트리거
  void _triggerSlideAnimation({required bool fromRight}) {
    setState(() {
      _slideAnimation = Tween<Offset>(
        begin: Offset(fromRight ? 0.3 : -0.3, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeOut,
      ));
    });
    _slideController.forward(from: 0.0);
  }

  /// 폴더 변경 시 스크롤 위치 저장 및 복원
  void _switchCollection(String? currentId, String? newId) {
    // 현재 폴더의 스크롤 위치 저장
    if (_listScrollController.hasClients) {
      _scrollPositions[currentId ?? 'all'] = _listScrollController.offset;
    }
    // 새 폴더의 저장된 위치로 이동 (없으면 0)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_listScrollController.hasClients) {
        final savedPosition = _scrollPositions[newId ?? 'all'] ?? 0.0;
        final maxScroll = _listScrollController.position.maxScrollExtent;
        _listScrollController.jumpTo(savedPosition.clamp(0.0, maxScroll));
      }
    });
  }

  /// 채널당 영상 개수 선택 다이얼로그
  Future<void> _showVideosPerChannelDialog() async {
    final currentCount = ref.read(videosPerChannelProvider);
    final l10n = AppLocalizations.of(context)!;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsVideosPerChannel),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [1, 2, 3, 5, 10, 15].map((count) {
            return RadioListTile<int>(
              title: Text(l10n.settingsVideosPerChannelCount(count)),
              value: count,
              groupValue: currentCount,
              onChanged: (value) {
                if (value != null) {
                  ref.read(videosPerChannelProvider.notifier).setVideosPerChannel(value);
                  Navigator.of(context).pop();
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  /// 컬렉션 보기 다이얼로그
  Future<void> _showCollectionViewDialog() async {
    final l10n = AppLocalizations.of(context)!;
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.settingsFolderView),
        content: Consumer(
          builder: (context, ref, child) {
            final isSingleLine = ref.watch(latestVideosChipLayoutSingleLineProvider);
            final showVideoCount = ref.watch(latestVideosShowVideoCountProvider);
            final isLarge = ref.watch(latestVideosCollectionSizeLargeProvider);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 한줄/줄바꿈 스위치
                SwitchListTile(
                  title: Text(isSingleLine ? l10n.chipLayoutToggleSingleLine : l10n.chipLayoutToggleWrap),
                  value: isSingleLine,
                  onChanged: (value) {
                    ref.read(latestVideosChipLayoutSingleLineProvider.notifier)
                        .setChipLayoutSingleLine(value);
                  },
                  contentPadding: EdgeInsets.zero,
                ),
                // 영상수 보기 체크박스
                CheckboxListTile(
                  title: Text(l10n.settingsShowVideoCount),
                  value: showVideoCount,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(latestVideosShowVideoCountProvider.notifier)
                          .setShowVideoCount(value);
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                ),
                // 크게/작게 스위치
                SwitchListTile(
                  title: Text(isLarge ? l10n.settingsFolderSizeLarge : l10n.settingsFolderSizeSmall),
                  value: isLarge,
                  onChanged: (value) {
                    ref.read(latestVideosCollectionSizeLargeProvider.notifier)
                        .setLarge(value);
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // 슬라이드 애니메이션 초기화
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      value: 1.0, // 초기값을 완료 상태로 설정
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });

    // 무한 스크롤 리스너
    _listScrollController.addListener(_onScroll);

    // 영상 로드 완료 시 컬렉션 카운트 업데이트
    ref.listenManual(latestVideosProvider, (previous, next) {
      // 로딩 완료 시 (isLoading이 true에서 false로 변경) 컬렉션 카운트 업데이트
      if (previous?.isLoading == true && !next.isLoading && next.allVideos.isNotEmpty) {
        _loadCollectionChannelIds();
      }
    });
  }

  void _onScroll() {
    if (!_listScrollController.hasClients) return;

    final maxScroll = _listScrollController.position.maxScrollExtent;
    final currentScroll = _listScrollController.position.pixels;
    final threshold = 200.0; // 하단 200px 전에 로드 시작

    if (maxScroll - currentScroll <= threshold) {
      ref.read(latestVideosProvider.notifier).loadMore();
    }
  }

  Future<void> _loadData() async {
    await ref.read(collectionsProvider.notifier).loadCollections();
    await _loadCollectionChannelIds();

    // 구독이 체크 안되어 있으면 첫 번째 체크된 폴더 선택
    final swipeEnabledIds = await ref.read(swipeEnabledCollectionsProvider.notifier).ensureLoaded();
    if (!swipeEnabledIds.contains(Constants.allChannelsFilterId) && swipeEnabledIds.isNotEmpty) {
      final collectionsState = ref.read(collectionsProvider);
      // 체크된 폴더 중 첫 번째 찾기
      for (final collection in collectionsState.collections) {
        if (swipeEnabledIds.contains(collection.id)) {
          ref.read(latestVideosProvider.notifier).setSelectedCollection(collection.id);
          break;
        }
      }
    }

    final state = ref.read(latestVideosProvider);
    if (state.allVideos.isEmpty && !state.isLoading) {
      ref.read(latestVideosProvider.notifier).fetchLatestVideos();
    }
  }

  Future<void> _loadCollectionChannelIds() async {
    final db = ref.read(databaseServiceProvider);

    // DB에서 직접 컬렉션 목록 가져오기
    final collections = await db.getAllCollections();

    // 모든 컬렉션의 채널 ID를 한 번에 로드
    final Map<String, Set<String>> newCollectionChannelIds = {};
    for (final collection in collections) {
      final channels = await db.getChannelsInCollection(collection.id);
      newCollectionChannelIds[collection.id] = channels.map((c) => c.id).toSet();
    }

    // 한 번에 setState
    if (mounted) {
      setState(() {
        _collectionChannelIds.clear();
        _collectionChannelIds.addAll(newCollectionChannelIds);
      });
    }
  }

  Widget _buildChipList(LatestVideosState state, CollectionsState collectionsState) {
    final isSingleLine = ref.watch(latestVideosChipLayoutSingleLineProvider);
    final showVideoCount = ref.watch(latestVideosShowVideoCountProvider);
    final isLarge = ref.watch(latestVideosCollectionSizeLargeProvider);

    final l10n = AppLocalizations.of(context)!;

    // 컬렉션별 영상 수 계산
    int getVideoCountForCollection(String collectionId) {
      final channelIds = _collectionChannelIds[collectionId];
      if (channelIds == null || channelIds.isEmpty) return 0;
      return state.allVideos.where((v) => channelIds.contains(v.channelId)).length;
    }

    final chips = <Widget>[
      // 구독중 (전체) 칩
      CollectionChipWidget(
        label: l10n.allChannelsFilter,
        isSelected: state.selectedCollectionId == null ||
            state.selectedCollectionId == Constants.allChannelsFilterId,
        showChannelCount: showVideoCount,
        channelCount: state.allVideos.length,
        isLarge: isLarge,
        onTap: () {
          _switchCollection(state.selectedCollectionId, null);
          ref.read(latestVideosProvider.notifier).setSelectedCollection(null);
        },
      ),
      // 컬렉션 칩들
      ...collectionsState.collections.map(
        (collection) => CollectionChipWidget(
          label: collection.name,
          color: collection.color,
          isSelected: state.selectedCollectionId == collection.id,
          showChannelCount: showVideoCount,
          channelCount: getVideoCountForCollection(collection.id),
          isLarge: isLarge,
          onTap: () {
            _switchCollection(state.selectedCollectionId, collection.id);
            ref.read(latestVideosProvider.notifier).setSelectedCollection(collection.id);
          },
        ),
      ),
    ];

    if (isSingleLine) {
      // 한줄 모드: 가로 스크롤
      // 선택된 칩으로 스크롤
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelectedChip(collectionsState.collections.length, state.selectedCollectionId);
      });

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: SingleChildScrollView(
          controller: _chipScrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: chips.map((chip) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: chip,
            )).toList(),
          ),
        ),
      );
    } else {
      // 줄바꿈 모드
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: chips,
        ),
      );
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _chipScrollController.dispose();
    _listScrollController.removeListener(_onScroll);
    _listScrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedChip(int collectionsLength, String? selectedCollectionId) {
    if (!_chipScrollController.hasClients) return;

    // 선택된 칩의 인덱스 찾기 (0 = 전체, 1~ = 컬렉션들)
    int selectedIndex = 0;
    if (selectedCollectionId != null && selectedCollectionId != Constants.allChannelsFilterId) {
      final collections = ref.read(collectionsProvider).collections;
      final index = collections.indexWhere((c) => c.id == selectedCollectionId);
      if (index != -1) {
        selectedIndex = index + 1; // 전체 칩 다음부터
      }
    }

    // 전체(all) 칩이 선택된 경우 맨 앞으로 스크롤
    if (selectedIndex == 0) {
      _chipScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    // 각 칩의 평균 너비 (한글 컬렉션명 기준)
    const double avgChipWidth = 70.0;
    const double chipSpacing = 8.0;

    // 선택된 칩이 화면에 보이도록 스크롤 (선택된 칩 앞에 1개 칩이 보이도록)
    final double targetScroll = ((selectedIndex - 1) * (avgChipWidth + chipSpacing)).clamp(
      0.0,
      _chipScrollController.position.maxScrollExtent,
    );

    _chipScrollController.animateTo(
      targetScroll,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(latestVideosProvider);
    final collectionsState = ref.watch(collectionsProvider);
    final l10n = AppLocalizations.of(context)!;

    // 설정 변경 시 즉시 반영을 위해 build에서 직접 watch
    ref.watch(videosPerChannelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navFeed),
        actions: [
          if (state.lastUpdated != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  _formatLastUpdated(context, state.lastUpdated!),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: state.isLoading
                ? null
                : () => ref.read(latestVideosProvider.notifier).refresh(),
          ),
          // 세로/가로 보기 토글 버튼
          Consumer(
            builder: (context, ref, _) {
              final layoutStyle = ref.watch(latestVideosLayoutProvider);
              final isVertical = layoutStyle == VideoCardLayoutStyle.vertical;
              return IconButton(
                icon: Icon(
                  isVertical ? Icons.view_list : Icons.view_agenda,
                  color: Colors.grey[400],
                ),
                onPressed: () {
                  final newStyle = isVertical
                      ? VideoCardLayoutStyle.horizontal
                      : VideoCardLayoutStyle.vertical;
                  ref.read(latestVideosLayoutProvider.notifier).setLayout(newStyle);
                },
                tooltip: isVertical ? '가로 보기' : '세로 보기',
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'videos_per_channel':
                  _showVideosPerChannelDialog();
                  break;
                case 'collection_view':
                  _showCollectionViewDialog();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'videos_per_channel',
                child: Row(
                  children: [
                    Icon(Icons.video_library, color: Colors.grey[400], size: 20),
                    const SizedBox(width: 12),
                    Text(l10n.settingsVideosPerChannel),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'collection_view',
                child: Row(
                  children: [
                    Icon(Icons.view_list, color: Colors.grey[400], size: 20),
                    const SizedBox(width: 12),
                    Text(l10n.settingsFolderView),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // 컬렉션 필터 칩 (항상 구독중 칩은 표시)
          _buildChipList(state, collectionsState),
          // 영상 목록 (좌우 스와이프로 컬렉션/메뉴 이동)
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragEnd: (details) async {
                if (details.primaryVelocity == null) return;

                // 스와이프 활성화된 컬렉션만 필터링 (로딩 완료 대기)
                final swipeEnabledIds = await ref.read(swipeEnabledCollectionsProvider.notifier).ensureLoaded();

                // 전체 컬렉션 목록 (순서 유지)
                final allCollections = collectionsState.collections;

                // 현재 선택된 컬렉션
                final currentId = state.selectedCollectionId ?? Constants.allChannelsFilterId;

                // 전체 목록에서 현재 위치 찾기
                int currentPositionInAll = -1;
                if (currentId == Constants.allChannelsFilterId) {
                  currentPositionInAll = -1; // all은 맨 앞 (인덱스 -1로 표현)
                } else {
                  currentPositionInAll = allCollections.indexWhere((c) => c.id == currentId);
                }

                final navOrder = ref.read(navOrderProvider);
                final currentNavIndex = ref.read(currentNavIndexProvider);

                // 스와이프 방향에 따라 이동
                if (details.primaryVelocity! < -300) {
                  // 왼쪽 스와이프 → 다음 스와이프 활성화 컬렉션 또는 다음 메뉴
                  String? nextId;

                  // 현재 위치 이후의 스와이프 활성화된 컬렉션 찾기
                  for (int i = currentPositionInAll + 1; i < allCollections.length; i++) {
                    if (swipeEnabledIds.contains(allCollections[i].id)) {
                      nextId = allCollections[i].id;
                      break;
                    }
                  }

                  if (nextId != null) {
                    _triggerSlideAnimation(fromRight: true);
                    _switchCollection(state.selectedCollectionId, nextId);
                    ref.read(latestVideosProvider.notifier).setSelectedCollection(nextId);
                  } else if (currentNavIndex < navOrder.length - 1) {
                    // 다음 스와이프 활성화 컬렉션이 없으면 다음 네비게이션 메뉴로 이동
                    ref.read(currentNavIndexProvider.notifier).state = currentNavIndex + 1;
                  }
                } else if (details.primaryVelocity! > 300) {
                  // 오른쪽 스와이프 → 이전 스와이프 활성화 컬렉션 또는 이전 메뉴
                  String? prevId;

                  // 현재 위치 이전의 스와이프 활성화된 컬렉션 찾기 (역순)
                  for (int i = currentPositionInAll - 1; i >= 0; i--) {
                    if (swipeEnabledIds.contains(allCollections[i].id)) {
                      prevId = allCollections[i].id;
                      break;
                    }
                  }

                  if (prevId != null) {
                    _triggerSlideAnimation(fromRight: false);
                    _switchCollection(state.selectedCollectionId, prevId);
                    ref.read(latestVideosProvider.notifier).setSelectedCollection(prevId);
                  } else if (currentPositionInAll >= 0 && (swipeEnabledIds.isEmpty || swipeEnabledIds.contains(Constants.allChannelsFilterId))) {
                    // 이전 스와이프 활성화 컬렉션이 없고 (체크된게 없거나 구독이 체크되어 있으면) 구독으로 이동
                    _triggerSlideAnimation(fromRight: false);
                    _switchCollection(state.selectedCollectionId, null);
                    ref.read(latestVideosProvider.notifier).setSelectedCollection(null);
                  } else if (currentNavIndex > 0) {
                    // 구독이 체크 안되어 있거나 구독에서 오른쪽 스와이프하면 이전 네비게이션 메뉴로 이동
                    ref.read(currentNavIndexProvider.notifier).state = currentNavIndex - 1;
                  }
                }
              },
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildBody(state),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(LatestVideosState state) {
    if (state.isLoading && state.allVideos.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(l10n.loadingVideos),
          ],
        ),
      );
    }

    if (state.errorMessage != null && state.allVideos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('오류: ${state.errorMessage}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.read(latestVideosProvider.notifier).fetchLatestVideos(),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    if (state.videos.isEmpty) {
      return const SizedBox.shrink();
    }

    final videos = state.videos;
    // 로딩 중이면 아이템 하나 추가 (로딩 인디케이터용)
    final itemCount = videos.length + (state.isLoadingMore ? 1 : 0);

    return RefreshIndicator(
      onRefresh: () => ref.read(latestVideosProvider.notifier).refresh(),
      child: ListView.builder(
        controller: _listScrollController,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          // 마지막 아이템이 로딩 인디케이터
          if (index == videos.length && state.isLoadingMore) {
            return _buildLoadingMoreIndicator();
          }
          final video = videos[index];
          return _VideoListItem(video: video);
        },
      ),
    );
  }

  Widget _buildLoadingMoreIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 12),
          Text(
            '영상을 불러오는 중...',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  String _formatLastUpdated(BuildContext context, DateTime dateTime) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) {
      return l10n.timeJustNow;
    } else if (diff.inMinutes < 60) {
      return l10n.timeMinutesAgo(diff.inMinutes);
    } else if (diff.inHours < 24) {
      return l10n.timeHoursAgo(diff.inHours);
    } else {
      return DateFormat('MM/dd HH:mm').format(dateTime);
    }
  }
}

class _VideoListItem extends ConsumerStatefulWidget {
  final Video video;

  const _VideoListItem({required this.video});

  @override
  ConsumerState<_VideoListItem> createState() => _VideoListItemState();
}

class _VideoListItemState extends ConsumerState<_VideoListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.5), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _toggleFavoriteWithAnimation() async {
    _animationController.forward(from: 0);
    await _toggleFavorite();
  }

  Future<void> _toggleFavorite() async {
    final favoritesNotifier = ref.read(favoritesProvider.notifier);
    final favorites = ref.read(favoritesProvider);

    final isFavorited = favorites.favorites.any((fav) => fav.videoId == widget.video.id);

    if (isFavorited) {
      await favoritesNotifier.removeFavorite(widget.video.id);
    } else {
      await favoritesNotifier.addFavorite(
        videoId: widget.video.id,
        channelId: widget.video.channelId,
        title: widget.video.title,
        channelTitle: widget.video.channelTitle,
        description: widget.video.description,
        thumbnailUrl: widget.video.thumbnailUrl,
        publishedAt: widget.video.publishedAt,
      );
    }
  }

  Future<void> _openInYouTube() async {
    final youtubeUrl = Uri.parse('https://www.youtube.com/watch?v=${widget.video.id}');
    if (await canLaunchUrl(youtubeUrl)) {
      await launchUrl(youtubeUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);
    final isFavorited = favorites.favorites.any((fav) => fav.videoId == widget.video.id);
    final layoutStyle = ref.watch(latestVideosLayoutProvider);

    // 레이아웃 스타일에 따라 다른 위젯 렌더링
    if (layoutStyle == VideoCardLayoutStyle.vertical) {
      return _buildVerticalCard(context, isFavorited);
    }

    return InkWell(
      onTap: _openInYouTube,
      onLongPress: _toggleFavoriteWithAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 썸네일
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 160,
                height: 90,
                child: CachedNetworkImage(
                  imageUrl: widget.video.thumbnailUrl ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 영상 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목
                  Text(
                    widget.video.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 채널 아이콘 + 채널명/시간 + 즐겨찾기
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 채널 아이콘 (2행 높이)
                      Consumer(
                        builder: (context, ref, _) {
                          final thumbnails = ref.watch(channelThumbnailsProvider);
                          return thumbnails.when(
                            data: (map) {
                              final thumbUrl = map[widget.video.channelId];
                              if (thumbUrl != null) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: thumbUrl,
                                      width: 36,
                                      height: 36,
                                      fit: BoxFit.cover,
                                      placeholder: (_, __) => Container(
                                        width: 36,
                                        height: 36,
                                        color: Colors.grey[700],
                                      ),
                                      errorWidget: (_, __, ___) => Container(
                                        width: 36,
                                        height: 36,
                                        color: Colors.grey[700],
                                        child: const Icon(Icons.person, size: 20),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                width: 36,
                                height: 36,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person, size: 20),
                              );
                            },
                            loading: () => Container(
                              width: 36,
                              height: 36,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                shape: BoxShape.circle,
                              ),
                            ),
                            error: (_, __) => Container(
                              width: 36,
                              height: 36,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person, size: 20),
                            ),
                          );
                        },
                      ),
                      // 채널명 + 시간
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.video.channelTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[400],
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _formatPublishedAt(context, widget.video.publishedAt),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 즐겨찾기 버튼 (북마크 아이콘) - 애니메이션 적용
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: IconButton(
                          icon: Icon(
                            isFavorited ? Icons.bookmark : Icons.bookmark_border,
                            color: isFavorited ? Colors.amber : Colors.grey,
                            size: 20,
                          ),
                          onPressed: _toggleFavoriteWithAnimation,
                          visualDensity: VisualDensity.compact,
                          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalCard(BuildContext context, bool isFavorited) {
    return InkWell(
      onTap: _openInYouTube,
      onLongPress: _toggleFavoriteWithAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 썸네일 (16:9 비율)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: widget.video.thumbnailUrl ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // 정보 영역
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 채널 아이콘 (36x36, 왼쪽 배치)
                Consumer(
                  builder: (context, ref, _) {
                    final thumbnails = ref.watch(channelThumbnailsProvider);
                    return thumbnails.when(
                      data: (map) {
                        final thumbUrl = map[widget.video.channelId];
                        if (thumbUrl != null) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: thumbUrl,
                                width: 36,
                                height: 36,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Container(
                                  width: 36,
                                  height: 36,
                                  color: Colors.grey[700],
                                ),
                                errorWidget: (_, __, ___) => Container(
                                  width: 36,
                                  height: 36,
                                  color: Colors.grey[700],
                                  child: const Icon(Icons.person, size: 20, color: Colors.grey),
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    );
                  },
                ),
                // 텍스트 영역
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.video.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.video.channelTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                          Text(
                            ' • ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            _formatPublishedAt(context, widget.video.publishedAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // 즐겨찾기 버튼 (북마크 아이콘) - 애니메이션 적용
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: IconButton(
                    icon: Icon(
                      isFavorited ? Icons.bookmark : Icons.bookmark_border,
                      color: isFavorited ? Colors.amber : Colors.grey,
                    ),
                    onPressed: _toggleFavoriteWithAnimation,
                    visualDensity: VisualDensity.compact,
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatPublishedAt(BuildContext context, DateTime publishedAt) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final diff = now.difference(publishedAt);

    if (diff.inMinutes < 60) {
      return l10n.timeMinutesAgo(diff.inMinutes);
    } else if (diff.inHours < 24) {
      return l10n.timeHoursAgo(diff.inHours);
    } else if (diff.inDays < 7) {
      return l10n.timeDaysAgo(diff.inDays);
    } else if (diff.inDays < 30) {
      return l10n.timeWeeksAgo((diff.inDays / 7).floor());
    } else if (diff.inDays < 365) {
      return l10n.timeMonthsAgo((diff.inDays / 30).floor());
    } else {
      return DateFormat('MMM d, yyyy').format(publishedAt);
    }
  }
}
