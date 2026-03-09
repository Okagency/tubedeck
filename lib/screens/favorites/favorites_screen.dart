import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/channels_provider.dart';
import '../../models/favorite_video.dart';
import '../../l10n/app_localizations.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _isSelectionMode = false;
  final Set<String> _selectedVideoIds = {};
  String? _selectedChannelId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favoritesProvider.notifier).loadFavorites();
    });
  }

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      if (!_isSelectionMode) {
        _selectedVideoIds.clear();
      }
    });
  }

  void _toggleLongTapMode() {
    ref.read(favoriteLongTapModeProvider.notifier).toggle();
  }

  void _selectAll() {
    final state = ref.read(favoritesProvider);
    setState(() {
      _selectedVideoIds.clear();
      _selectedVideoIds.addAll(state.favorites.map((f) => f.videoId));
    });
  }

  void _deleteSelected() async {
    if (_selectedVideoIds.isEmpty) return;

    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteConfirmTitle),
        content: Text(l10n.deleteSelectedVideosConfirm(_selectedVideoIds.length)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final notifier = ref.read(favoritesProvider.notifier);
      for (final videoId in _selectedVideoIds) {
        await notifier.removeFavorite(videoId);
      }
      setState(() {
        _selectedVideoIds.clear();
        _isSelectionMode = false;
      });
    }
  }

  void _toggleSelection(String videoId) {
    setState(() {
      if (_selectedVideoIds.contains(videoId)) {
        _selectedVideoIds.remove(videoId);
      } else {
        _selectedVideoIds.add(videoId);
      }
    });
  }

  /// 삭제 (설정에 따라 확인 메시지 표시)
  Future<void> _deleteSingle(String videoId) async {
    final showDeleteConfirm = ref.read(favoriteDeleteConfirmProvider);
    if (showDeleteConfirm) {
      final l10n = AppLocalizations.of(context)!;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.delete),
          content: Text(l10n.deleteFavoriteConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );

      if (confirmed == true && mounted) {
        await ref.read(favoritesProvider.notifier).removeFavorite(videoId);
      }
    } else {
      await ref.read(favoritesProvider.notifier).removeFavorite(videoId);
    }
  }

  void _showChannelFilterBottomSheet(BuildContext context, FavoritesState state) {
    final l10n = AppLocalizations.of(context)!;

    // 즐겨찾기에 있는 채널 목록 추출 (중복 제거)
    final channelMap = <String, String>{};
    for (final fav in state.favorites) {
      channelMap[fav.channelId] = fav.channelTitle;
    }
    final channels = channelMap.entries.toList()
      ..sort((a, b) => a.value.toLowerCase().compareTo(b.value.toLowerCase()));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                // 핸들바
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // 제목
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    l10n.filterByChannel,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                // 전체 보기 옵션
                ListTile(
                  leading: const Icon(Icons.all_inclusive),
                  title: Text(l10n.allChannels),
                  trailing: _selectedChannelId == null
                      ? const Icon(Icons.check, color: Colors.amber)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedChannelId = null;
                    });
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                // 채널 목록
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: channels.length,
                    itemBuilder: (context, index) {
                      final channel = channels[index];
                      final videoCount = state.favorites
                          .where((f) => f.channelId == channel.key)
                          .length;
                      final isSelected = _selectedChannelId == channel.key;

                      return ListTile(
                        leading: Consumer(
                          builder: (context, ref, _) {
                            final thumbnails = ref.watch(channelThumbnailsProvider);
                            return thumbnails.when(
                              data: (map) {
                                final thumbUrl = map[channel.key];
                                if (thumbUrl != null) {
                                  return ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: thumbUrl,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                      placeholder: (_, __) => Container(
                                        width: 40,
                                        height: 40,
                                        color: Colors.grey[700],
                                      ),
                                      errorWidget: (_, __, ___) => Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[700],
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.person, size: 24),
                                      ),
                                    ),
                                  );
                                }
                                return Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[700],
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.person, size: 24),
                                );
                              },
                              loading: () => Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              error: (_, __) => Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person, size: 24),
                              ),
                            );
                          },
                        ),
                        title: Text(
                          channel.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(l10n.videoCount(videoCount)),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: Colors.amber)
                            : null,
                        onTap: () {
                          setState(() {
                            _selectedChannelId = channel.key;
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSelectionMode
            ? Text(AppLocalizations.of(context)!.itemsSelected(_selectedVideoIds.length))
            : Text(AppLocalizations.of(context)!.navFavorites),
        leading: _isSelectionMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _toggleSelectionMode,
              )
            : null,
        actions: [
          if (_isSelectionMode) ...[
            IconButton(
              icon: const Icon(Icons.select_all),
              onPressed: _selectAll,
              tooltip: AppLocalizations.of(context)!.selectAll,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _selectedVideoIds.isEmpty ? null : _deleteSelected,
              tooltip: AppLocalizations.of(context)!.delete,
            ),
          ] else if (state.favorites.isNotEmpty) ...[
            // 1. 개수 표시 (왼쪽)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Center(
                child: Text(
                  _selectedChannelId != null
                      ? AppLocalizations.of(context)!.itemCount(
                          state.favorites.where((f) => f.channelId == _selectedChannelId).length)
                      : AppLocalizations.of(context)!.itemCount(state.favorites.length),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
            // 2. 채널 필터 버튼
            IconButton(
              icon: Icon(
                Icons.tune,
                color: _selectedChannelId != null ? Colors.amber : Colors.grey[400],
              ),
              onPressed: () => _showChannelFilterBottomSheet(context, state),
            ),
            // 3. 선택 모드 버튼
            IconButton(
              icon: const Icon(Icons.checklist),
              onPressed: _toggleSelectionMode,
              tooltip: AppLocalizations.of(context)!.select,
            ),
            // 4. 세로/가로 보기 토글 버튼
            Consumer(
              builder: (context, ref, _) {
                final layoutStyle = ref.watch(favoritesLayoutProvider);
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
                    ref.read(favoritesLayoutProvider.notifier).setLayout(newStyle);
                  },
                  tooltip: isVertical ? '가로 보기' : '세로 보기',
                );
              },
            ),
            // 5. 점세개 메뉴 (오른쪽)
            Consumer(
              builder: (context, ref, _) {
                final longTapMode = ref.watch(favoriteLongTapModeProvider);
                final showDeleteConfirm = ref.watch(favoriteDeleteConfirmProvider);
                return PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.grey[400]),
                  onSelected: (value) {
                    if (value == 'longTapMode') {
                      _toggleLongTapMode();
                    } else if (value == 'deleteConfirm') {
                      ref.read(favoriteDeleteConfirmProvider.notifier).toggle();
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      value: 'longTapMode',
                      child: Row(
                        children: [
                          Icon(
                            longTapMode == FavoriteLongTapMode.reorder
                                ? Icons.swap_vert
                                : Icons.delete,
                            size: 20,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 12),
                          Text(longTapMode == FavoriteLongTapMode.reorder
                              ? AppLocalizations.of(context)!.longPressReorder
                              : AppLocalizations.of(context)!.longPressDelete),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'deleteConfirm',
                      child: Row(
                        children: [
                          Icon(
                            showDeleteConfirm
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            size: 20,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 12),
                          Text(AppLocalizations.of(context)!.showDeleteConfirmation),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ],
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity == null) return;

          final navOrder = ref.read(navOrderProvider);
          final currentNavIndex = ref.read(currentNavIndexProvider);

          // 스와이프 방향에 따라 메뉴 이동
          if (details.primaryVelocity! < -300) {
            // 왼쪽 스와이프 → 다음 메뉴
            if (currentNavIndex < navOrder.length - 1) {
              ref.read(currentNavIndexProvider.notifier).state = currentNavIndex + 1;
            }
          } else if (details.primaryVelocity! > 300) {
            // 오른쪽 스와이프 → 이전 메뉴
            if (currentNavIndex > 0) {
              ref.read(currentNavIndexProvider.notifier).state = currentNavIndex - 1;
            }
          }
        },
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(FavoritesState state) {
    if (state.isLoading && state.favorites.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.favorites.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark, size: 64, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.noFavorites,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    // 채널 필터 적용
    final filteredFavorites = _selectedChannelId != null
        ? state.favorites.where((f) => f.channelId == _selectedChannelId).toList()
        : state.favorites;

    // 필터링 후 결과가 없으면 메시지 표시
    if (filteredFavorites.isEmpty && _selectedChannelId != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark, size: 64, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.noFavorites,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    final longTapMode = ref.watch(favoriteLongTapModeProvider);

    // 채널 필터가 적용된 경우 일반 ListView 사용 (순서 변경 불가)
    if (_selectedChannelId != null) {
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: filteredFavorites.length,
        itemBuilder: (context, index) {
          final favorite = filteredFavorites[index];
          return _FavoriteListItem(
            key: ValueKey(favorite.videoId),
            favorite: favorite,
            isSelectionMode: _isSelectionMode,
            isSelected: _selectedVideoIds.contains(favorite.videoId),
            onToggleSelection: () => _toggleSelection(favorite.videoId),
            onDelete: () => _deleteSingle(favorite.videoId),
            longTapMode: longTapMode,
            index: index,
          );
        },
      );
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: filteredFavorites.length,
      onReorder: _isSelectionMode
          ? (oldIndex, newIndex) {} // 선택 모드에서만 재정렬 비활성화
          : (oldIndex, newIndex) {
              ref.read(favoritesProvider.notifier).reorderFavorites(oldIndex, newIndex);
            },
      itemBuilder: (context, index) {
        final favorite = filteredFavorites[index];
        return _FavoriteListItem(
          key: ValueKey(favorite.videoId),
          favorite: favorite,
          isSelectionMode: _isSelectionMode,
          isSelected: _selectedVideoIds.contains(favorite.videoId),
          onToggleSelection: () => _toggleSelection(favorite.videoId),
          onDelete: () => _deleteSingle(favorite.videoId),
          longTapMode: longTapMode,
          index: index,
        );
      },
    );
  }
}

class _FavoriteListItem extends ConsumerWidget {
  final FavoriteVideo favorite;
  final VoidCallback onDelete;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback onToggleSelection;
  final FavoriteLongTapMode longTapMode;
  final int index;

  const _FavoriteListItem({
    super.key,
    required this.favorite,
    required this.onDelete,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onToggleSelection,
    required this.longTapMode,
    required this.index,
  });

  Future<void> _openInYouTube() async {
    final youtubeUrl = Uri.parse('https://www.youtube.com/watch?v=${favorite.videoId}');
    if (await canLaunchUrl(youtubeUrl)) {
      await launchUrl(youtubeUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutStyle = ref.watch(favoritesLayoutProvider);

    // 레이아웃 스타일에 따라 다른 위젯 렌더링 (선택 모드가 아닐 때만)
    if (layoutStyle == VideoCardLayoutStyle.vertical && !isSelectionMode) {
      return _buildVerticalCard(context);
    }

    return InkWell(
      onTap: () {
        if (isSelectionMode) {
          onToggleSelection();
        } else {
          _openInYouTube();
        }
      },
      onLongPress: longTapMode == FavoriteLongTapMode.delete ? onDelete : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 썸네일
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 140,
                height: 79,
                child: CachedNetworkImage(
                  imageUrl: favorite.thumbnailUrl ?? '',
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
                    favorite.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 채널 아이콘 + 채널명/시간 + 삭제버튼
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 채널 아이콘 (2행 높이)
                      Consumer(
                        builder: (context, ref, _) {
                          final thumbnails = ref.watch(channelThumbnailsProvider);
                          return thumbnails.when(
                            data: (map) {
                              final thumbUrl = map[favorite.channelId];
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
                              favorite.channelTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[400],
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _formatPublishedAt(context, favorite.publishedAt),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 선택 모드: 체크박스 / 삭제 모드: 드래그 핸들 / 순서정렬 모드: 삭제 버튼
                      if (isSelectionMode)
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: isSelected,
                            onChanged: (_) => onToggleSelection(),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                      else if (longTapMode == FavoriteLongTapMode.delete)
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {}, // 탭 이벤트 흡수
                          onLongPress: () {}, // 롱탭 이벤트 흡수 (삭제 방지)
                          child: ReorderableDragStartListener(
                            index: index,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.drag_handle,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      else
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: onDelete,
                          visualDensity: VisualDensity.compact,
                          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                          padding: EdgeInsets.zero,
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

  Widget _buildVerticalCard(BuildContext context) {
    return InkWell(
      onTap: _openInYouTube,
      onLongPress: longTapMode == FavoriteLongTapMode.delete ? onDelete : null,
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
                  imageUrl: favorite.thumbnailUrl ?? '',
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
                        final thumbUrl = map[favorite.channelId];
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
                        favorite.title,
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
                              favorite.channelTitle,
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
                            _formatPublishedAt(context, favorite.publishedAt),
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
                // 삭제 모드: 드래그 핸들 / 순서정렬 모드: 삭제 버튼
                if (longTapMode == FavoriteLongTapMode.delete)
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {}, // 탭 이벤트 흡수
                    onLongPress: () {}, // 롱탭 이벤트 흡수 (삭제 방지)
                    child: ReorderableDragStartListener(
                      index: index,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.drag_handle,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                else
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onPressed: onDelete,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
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
