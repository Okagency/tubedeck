import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../l10n/app_localizations.dart';
import '../../models/video.dart';
import '../../services/rss_service.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/settings_provider.dart';

class ChannelVideosScreen extends ConsumerStatefulWidget {
  final String channelId;
  final String channelTitle;
  final String? channelThumbnailUrl;

  const ChannelVideosScreen({
    super.key,
    required this.channelId,
    required this.channelTitle,
    this.channelThumbnailUrl,
  });

  @override
  ConsumerState<ChannelVideosScreen> createState() => _ChannelVideosScreenState();
}

class _ChannelVideosScreenState extends ConsumerState<ChannelVideosScreen> {
  final RssService _rssService = RssService();
  List<Video> _videos = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final videos = await _rssService.fetchVideosFromChannel(
        widget.channelId,
        widget.channelTitle,
        maxResults: 15, // 최대 15개 영상
        throwOnError: true, // 에러 시 예외 발생
      );
      setState(() {
        _videos = videos;
        _isLoading = false;
      });
    } on RssException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
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
                    // 채널 썸네일
                    if (widget.channelThumbnailUrl != null)
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget.channelThumbnailUrl!,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[800],
                            width: 32,
                            height: 32,
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[800],
                            width: 32,
                            height: 32,
                            child: const Icon(Icons.person, size: 16),
                          ),
                        ),
                      ),
                    if (widget.channelThumbnailUrl != null) const SizedBox(width: 10),
                    // 채널 제목
                    Expanded(
                      child: Text(
                        widget.channelTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // 유튜브에서 열기 버튼
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.youtube, color: Color(0xFFFF0000)),
                      onPressed: () async {
                        final url = Uri.parse('https://www.youtube.com/channel/${widget.channelId}');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                      tooltip: AppLocalizations.of(context)!.settingsChannelTapOpenYoutube,
                    ),
                    // 세로/가로 보기 토글 버튼
                    Consumer(
                      builder: (context, ref, _) {
                        final layoutStyle = ref.watch(channelVideosLayoutProvider);
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
                            ref.read(channelVideosLayoutProvider.notifier).setLayout(newStyle);
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
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.video_library_outlined, size: 64, color: Colors.grey[600]),
              const SizedBox(height: 24),
              Text(
                '영상을 불러올 수 없습니다',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () async {
                  final url = Uri.parse('https://www.youtube.com/channel/${widget.channelId}/videos');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                icon: const FaIcon(FontAwesomeIcons.youtube, size: 18),
                label: const Text('YouTube에서 열기'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF0000),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(AppLocalizations.of(context)!.errorDetail),
                      content: Text(_errorMessage!),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(AppLocalizations.of(context)!.confirm),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.viewErrorMessage,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_videos.isEmpty) {
      return const Center(child: Text('영상이 없습니다'));
    }

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 100,
      ),
      itemCount: _videos.length,
      itemBuilder: (context, index) {
        final video = _videos[index];
        return _VideoListItem(video: video);
      },
    );
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
    final layoutStyle = ref.watch(channelVideosLayoutProvider);

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
                  const SizedBox(height: 8),
                  // 시간 + 즐겨찾기 버튼
                  Row(
                    children: [
                      Text(
                        _formatPublishedAt(context, widget.video.publishedAt),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                      ),
                      const Spacer(),
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
                // 텍스트 정보
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
                        _formatPublishedAt(context, widget.video.publishedAt),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
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
