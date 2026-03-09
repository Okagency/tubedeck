import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/settings_provider.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/channels_provider.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  final String videoId;
  final String videoTitle;
  final String channelId;
  final String channelTitle;
  final DateTime publishedAt;
  final String? description;

  const VideoPlayerScreen({
    super.key,
    required this.videoId,
    required this.videoTitle,
    required this.channelId,
    required this.channelTitle,
    required this.publishedAt,
    this.description,
  });

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  // 스와이프 관련 변수
  double _dragOffset = 0.0;
  bool _isDragging = false;
  double _dragStartY = 0.0;
  double _dragStartX = 0.0;

  // 더블탭 관련 변수
  double? _doubleTapX;

  // 즐겨찾기 상태
  bool _isFavorite = false;

  // 전체화면 모드
  bool _isFullScreen = false;

  // 초기 가로 모드 전체화면 처리 여부
  bool _initialFullScreenHandled = false;

  // 자막 상태
  bool _enableCaption = false;

  @override
  void initState() {
    super.initState();

    // 자막 설정 가져오기
    _enableCaption = ref.read(enableCaptionProvider);

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: _enableCaption,
        forceHD: false,
        hideControls: false,
        disableDragSeek: false,
      ),
    );

    // 즐겨찾기 상태 확인
    _checkFavoriteStatus();
  }

  // 자막 토글
  void _toggleCaption() {
    final currentPosition = _controller.value.position;
    final wasPlaying = _controller.value.isPlaying;

    _controller.dispose();

    _enableCaption = !_enableCaption;

    // 설정 저장
    ref.read(enableCaptionProvider.notifier).setEnableCaption(_enableCaption);

    // 새 컨트롤러 생성
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: wasPlaying,
        mute: false,
        enableCaption: _enableCaption,
        forceHD: false,
        hideControls: false,
        disableDragSeek: false,
        startAt: currentPosition.inSeconds,
      ),
    );

    // 새 컨트롤러로 위젯 리빌드
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 초기 가로 모드일 때 전체화면으로 시작
    if (!_initialFullScreenHandled) {
      _initialFullScreenHandled = true;
      final orientation = MediaQuery.of(context).orientation;
      if (orientation == Orientation.landscape) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_isFullScreen) {
            _controller.toggleFullScreenMode();
          }
        });
      }
    }
  }

  Future<void> _checkFavoriteStatus() async {
    final isFav = await ref.read(favoritesProvider.notifier).isFavorite(widget.videoId);
    if (mounted) {
      setState(() {
        _isFavorite = isFav;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    final result = await ref.read(favoritesProvider.notifier).toggleFavorite(
      videoId: widget.videoId,
      channelId: widget.channelId,
      title: widget.videoTitle,
      channelTitle: widget.channelTitle,
      description: widget.description,
      thumbnailUrl: 'https://img.youtube.com/vi/${widget.videoId}/hqdefault.jpg',
      publishedAt: widget.publishedAt,
    );
    if (mounted) {
      setState(() {
        _isFavorite = result;
      });
    }
  }

  // 유튜브 앱에서 재생 (현재 위치부터)
  Future<void> _openInYouTube() async {
    final currentSeconds = _controller.value.position.inSeconds;
    final youtubeUrl = Uri.parse(
      'https://www.youtube.com/watch?v=${widget.videoId}&t=${currentSeconds}s',
    );

    if (await canLaunchUrl(youtubeUrl)) {
      await launchUrl(youtubeUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    // 시스템 UI 복원 (전체화면 종료 후 네비게이션 바 복원)
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  // 영상 앞으로 이동 (10초)
  void _seekForward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition + const Duration(seconds: 10);
    _controller.seekTo(newPosition);
  }

  // 영상 뒤로 이동 (10초)
  void _seekBackward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - const Duration(seconds: 10);
    _controller.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  // 제스처가 적용된 플레이어 위젯
  Widget _buildPlayerWithGestures(Widget player) {
    // Listener를 사용하여 드래그 감지 (탭 이벤트를 플레이어에 전달하기 위해)
    return Listener(
      onPointerDown: (details) {
        _dragStartY = details.position.dy;
        _dragStartX = details.position.dx;
        _dragOffset = 0;
        _isDragging = false;
      },
      onPointerMove: (details) {
        final deltaY = details.position.dy - _dragStartY;
        final deltaX = details.position.dx - _dragStartX;

        // 아래로 드래그 감지 (최소 20픽셀 이상 이동해야 드래그로 인식)
        if (deltaY.abs() > deltaX.abs() && deltaY > 20) {
          setState(() {
            _isDragging = true;
            _dragOffset = deltaY;
          });
        }
      },
      onPointerUp: (details) {
        final screenHeight = MediaQuery.of(context).size.height;

        // 드래그 거리가 충분하면 화면 닫기
        if (_isDragging && _dragOffset > screenHeight / 4) {
          Navigator.of(context).pop();
        }

        setState(() {
          _dragOffset = 0;
          _isDragging = false;
        });
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onDoubleTapDown: (details) {
          final renderBox = context.findRenderObject() as RenderBox;
          final localPosition = renderBox.globalToLocal(details.globalPosition);
          _doubleTapX = localPosition.dx;
        },
        onDoubleTap: () {
          if (_doubleTapX != null) {
            final renderBox = context.findRenderObject() as RenderBox;
            final playerWidth = renderBox.size.width;

            if (_doubleTapX! < playerWidth / 2) {
              _seekBackward();
            } else {
              _seekForward();
            }
            _doubleTapX = null;
          }
        },
        child: Transform.translate(
          offset: Offset(0, _isDragging ? _dragOffset * 0.3 : 0),
          child: Opacity(
            opacity: _isDragging ? (1.0 - (_dragOffset / 500).clamp(0.0, 0.3)) : 1.0,
            child: player,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      key: ValueKey(_enableCaption), // 자막 변경 시 플레이어 완전 리빌드
      onEnterFullScreen: () {
        setState(() {
          _isFullScreen = true;
        });
      },
      onExitFullScreen: () {
        setState(() {
          _isFullScreen = false;
        });
        // 시스템 UI 복원
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
          bufferedColor: Colors.white54,
          backgroundColor: Colors.grey,
        ),
        topActions: [
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              widget.videoTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // 자막 토글 버튼 (상단 우측)
          IconButton(
            icon: Icon(
              _enableCaption ? Icons.closed_caption : Icons.closed_caption_off,
              color: _enableCaption ? Colors.blue : Colors.white,
              size: _isFullScreen ? 28 : 24,
            ),
            onPressed: _toggleCaption,
            tooltip: _enableCaption ? '자막 끄기' : '자막 켜기',
          ),
          // 전체화면에서 유튜브로 열기 버튼 (상단 우측)
          if (_isFullScreen)
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.youtube,
                color: Color(0xFFFF0000),
                size: 28,
              ),
              onPressed: _openInYouTube,
            ),
        ],
        bottomActions: [
          const SizedBox(width: 14),
          CurrentPosition(),
          const SizedBox(width: 8),
          ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
              bufferedColor: Colors.white54,
              backgroundColor: Colors.grey,
            ),
          ),
          RemainingDuration(),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white, size: _isFullScreen ? 36 : 24),
            onPressed: () {
              _controller.pause();
              Navigator.of(context).pop();
            },
          ),
        ],
        onReady: () {
          // 플레이어 준비 완료
        },
        onEnded: (data) {
          Navigator.of(context).pop();
        },
      ),
      builder: (context, player) {
        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              _controller.pause();
            }
          },
          child: Scaffold(
            body: SafeArea(
              bottom: true,
              child: Column(
                children: [
                  _buildPlayerWithGestures(player),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 제목
                          Text(
                            widget.videoTitle,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // 채널명 & 등록일
                          Row(
                            children: [
                              Text(
                                widget.channelTitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '•',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(widget.publishedAt),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // 채널 아이콘 & 버튼들
                          Row(
                            children: [
                              // 채널 아이콘 (왼쪽)
                              Consumer(
                                builder: (context, ref, _) {
                                  final thumbnails = ref.watch(channelThumbnailsProvider);
                                  return thumbnails.when(
                                    data: (map) {
                                      final thumbUrl = map[widget.channelId];
                                      if (thumbUrl != null) {
                                        return ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: thumbUrl,
                                            width: 48,
                                            height: 48,
                                            fit: BoxFit.cover,
                                            placeholder: (_, __) => Container(
                                              width: 48,
                                              height: 48,
                                              color: Colors.grey[700],
                                            ),
                                            errorWidget: (_, __, ___) => Container(
                                              width: 48,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[700],
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.person, color: Colors.grey),
                                            ),
                                          ),
                                        );
                                      }
                                      return Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[700],
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.person, color: Colors.grey),
                                      );
                                    },
                                    loading: () => Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[700],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    error: (_, __) => Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[700],
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.person, color: Colors.grey),
                                    ),
                                  );
                                },
                              ),
                              const Spacer(),
                              // 즐겨찾기 버튼 (북마크 아이콘)
                              GestureDetector(
                                onTap: _toggleFavorite,
                                child: Icon(
                                  _isFavorite ? Icons.bookmark : Icons.bookmark_border,
                                  color: _isFavorite ? Colors.amber : Colors.grey[400],
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              // 유튜브에서 재생 버튼
                              IconButton(
                                onPressed: _openInYouTube,
                                icon: const FaIcon(
                                  FontAwesomeIcons.youtube,
                                  size: 24,
                                  color: Color(0xFFFF0000),
                                ),
                                tooltip: 'YouTube에서 재생',
                              ),
                            ],
                          ),
                          // 설명
                          if (widget.description != null && widget.description!.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 8),
                            Text(
                              widget.description!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[300],
                                height: 1.5,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
