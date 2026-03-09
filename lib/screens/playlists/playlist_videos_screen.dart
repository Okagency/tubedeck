import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';
import '../../models/video.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/settings_provider.dart';

class PlaylistVideosScreen extends ConsumerStatefulWidget {
  final String playlistId;
  final String playlistTitle;
  final List<Video> videos;

  const PlaylistVideosScreen({
    super.key,
    required this.playlistId,
    required this.playlistTitle,
    required this.videos,
  });

  @override
  ConsumerState<PlaylistVideosScreen> createState() => _PlaylistVideosScreenState();
}

class _PlaylistVideosScreenState extends ConsumerState<PlaylistVideosScreen> {
  List<Video> _getSortedVideos(PlaylistVideosSortOrder sortOrder) {
    final videos = List<Video>.from(widget.videos);

    switch (sortOrder) {
      case PlaylistVideosSortOrder.playlistOrder:
        // 원본 순서 유지
        return videos;
      case PlaylistVideosSortOrder.playlistOrderReverse:
        // 재생목록 역순
        return videos.reversed.toList();
      case PlaylistVideosSortOrder.newest:
        videos.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
        return videos;
      case PlaylistVideosSortOrder.oldest:
        videos.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
        return videos;
      case PlaylistVideosSortOrder.title:
        videos.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        return videos;
    }
  }

  void _showSortOptions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentSort = ref.read(playlistVideosSortOrdersProvider.notifier).getSortOrder(widget.playlistId);

    // 모든 정렬 옵션
    final sortOptions = PlaylistVideosSortOrder.values;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.sortDialogTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: sortOptions.map((sortOrder) {
              return RadioListTile<PlaylistVideosSortOrder>(
                title: Text(sortOrder.getDisplayName(l10n)),
                value: sortOrder,
                groupValue: currentSort,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(playlistVideosSortOrdersProvider.notifier).setSortOrder(widget.playlistId, value);
                    Navigator.of(dialogContext).pop();
                  }
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.0,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1C1C1C),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // 드래그 핸들 (강조)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Center(
                  child: Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Divider(height: 0.5, thickness: 0.5, color: Colors.grey[600], indent: 16, endIndent: 16),
              // 헤더 (기존 AppBar 내용)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    // 재생목록 제목
                    Expanded(
                      child: Text(
                        widget.playlistTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // 정렬 버튼
                    IconButton(
                      icon: Icon(
                        Icons.sort,
                        color: Colors.grey[400],
                      ),
                      onPressed: () => _showSortOptions(context),
                    ),
                    // 세로/가로 보기 토글 버튼
                    Consumer(
                      builder: (context, ref, _) {
                        final layoutStyle = ref.watch(playlistVideosLayoutProvider);
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
                            ref.read(playlistVideosLayoutProvider.notifier).setLayout(newStyle);
                          },
                          tooltip: isVertical ? '가로 보기' : '세로 보기',
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // 본문 (영상 리스트)
              Expanded(child: _buildBody(scrollController)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(ScrollController scrollController) {
    if (widget.videos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_library, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.noVideos,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return Consumer(
      builder: (context, ref, _) {
        final sortOrder = ref.watch(playlistVideosSortOrdersProvider)[widget.playlistId]
            ?? PlaylistVideosSortOrder.playlistOrder;
        final sortedVideos = _getSortedVideos(sortOrder);

        return ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
            bottom: MediaQuery.of(context).padding.bottom + 100,
          ),
          itemCount: sortedVideos.length,
          itemBuilder: (context, index) {
            final video = sortedVideos[index];
            return _PlaylistVideoListItem(video: video);
          },
        );
      },
    );
  }

}

class _PlaylistVideoListItem extends ConsumerStatefulWidget {
  final Video video;

  const _PlaylistVideoListItem({required this.video});

  @override
  ConsumerState<_PlaylistVideoListItem> createState() => _PlaylistVideoListItemState();
}

class _PlaylistVideoListItemState extends ConsumerState<_PlaylistVideoListItem>
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

  String _formatPublishedDate(BuildContext context, DateTime date) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return l10n.timeYearsAgo((difference.inDays / 365).floor());
    } else if (difference.inDays > 30) {
      return l10n.timeMonthsAgo((difference.inDays / 30).floor());
    } else if (difference.inDays > 7) {
      return l10n.timeWeeksAgo((difference.inDays / 7).floor());
    } else if (difference.inDays > 0) {
      return l10n.timeDaysAgo(difference.inDays);
    } else if (difference.inHours > 0) {
      return l10n.timeHoursAgo(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return l10n.timeMinutesAgo(difference.inMinutes);
    } else {
      return l10n.timeJustNow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);
    final isFavorited = favorites.favorites.any((fav) => fav.videoId == widget.video.id);
    final layoutStyle = ref.watch(playlistVideosLayoutProvider);

    if (layoutStyle == VideoCardLayoutStyle.vertical) {
      return _buildVerticalCard(context, isFavorited);
    }

    return _buildHorizontalCard(context, isFavorited);
  }

  Widget _buildHorizontalCard(BuildContext context, bool isFavorited) {
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
                  Text(
                    widget.video.channelTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        _formatPublishedDate(context, widget.video.publishedAt),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                      ),
                      const Spacer(),
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
                            _formatPublishedDate(context, widget.video.publishedAt),
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
}
