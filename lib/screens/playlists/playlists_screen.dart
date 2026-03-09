import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/playlists_provider.dart';
import '../../models/playlist.dart';
import '../../utils/helpers.dart';
import '../../providers/settings_provider.dart';
import '../../l10n/app_localizations.dart';
import 'playlist_videos_screen.dart';

class PlaylistsScreen extends ConsumerStatefulWidget {
  const PlaylistsScreen({super.key});

  @override
  ConsumerState<PlaylistsScreen> createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends ConsumerState<PlaylistsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _hasLoadedCache = false;

  @override
  void initState() {
    super.initState();
    // 캐시된 재생목록 로드 (첫 로드 시에만)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasLoadedCache) {
        _hasLoadedCache = true;
        final state = ref.read(playlistsProvider);
        if (state.playlists.isEmpty && !state.isLoading) {
          ref.read(playlistsProvider.notifier).loadCachedPlaylists();
        }
      }
    });
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
    super.build(context); // AutomaticKeepAliveClientMixin 필수
    final playlistsState = ref.watch(playlistsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.navPlaylists),
        actions: [
          // 정렬 토글 버튼
          IconButton(
            icon: Icon(
              playlistsState.sortMode == PlaylistSortMode.custom
                  ? Icons.swap_vert
                  : Icons.sort_by_alpha,
            ),
            tooltip: playlistsState.sortMode == PlaylistSortMode.custom
                ? AppLocalizations.of(context)!.customOrder
                : AppLocalizations.of(context)!.alphabetical,
            onPressed: () {
              ref.read(playlistsProvider.notifier).toggleSortMode();
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 'refresh') {
                if (!playlistsState.isLoading) {
                  try {
                    await ref.read(playlistsProvider.notifier).fetchPlaylists();
                    if (mounted) {
                      final state = ref.read(playlistsProvider);
                      Helpers.showSnackBar(
                        context,
                        AppLocalizations.of(context)!.playlistCount(state.playlists.length),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      Helpers.showSnackBar(
                        context,
                        Helpers.getErrorMessage(e, context),
                        isError: true,
                      );
                    }
                  }
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'refresh',
                enabled: !playlistsState.isLoading,
                child: Row(
                  children: [
                    Icon(Icons.refresh, size: 20, color: Colors.grey[400]),
                    const SizedBox(width: 12),
                    Text(AppLocalizations.of(context)!.refreshPlaylists),
                  ],
                ),
              ),
            ],
          ),
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
        child: _buildPlaylistsList(playlistsState),
      ),
    );
  }

  Widget _buildPlaylistsList(PlaylistsState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.cannotLoadPlaylists,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                state.errorMessage!,
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(playlistsProvider.notifier).fetchPlaylists();
              },
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      );
    }

    if (state.playlists.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_library, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.noPlaylists,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    // 사용자 정의 모드면 ReorderableListView 사용
    if (state.sortMode == PlaylistSortMode.custom) {
      return ReorderableListView.builder(
        padding: EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
          bottom: MediaQuery.of(context).padding.bottom + 100,
        ),
        itemCount: state.playlists.length,
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) newIndex--;
          ref.read(playlistsProvider.notifier).reorderPlaylist(oldIndex, newIndex);
        },
        itemBuilder: (context, index) {
          final playlist = state.playlists[index];
          return _buildPlaylistCard(playlist, key: ValueKey(playlist.id), showDragHandle: true);
        },
      );
    }

    // 가나다 순 모드면 일반 ListView
    return ListView.builder(
      padding: EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8,
        bottom: MediaQuery.of(context).padding.bottom + 100,
      ),
      itemCount: state.playlists.length,
      itemBuilder: (context, index) {
        final playlist = state.playlists[index];
        return _buildPlaylistCard(playlist, showDragHandle: false);
      },
    );
  }

  Widget _buildPlaylistCard(Playlist playlist, {Key? key, required bool showDragHandle}) {
    return Card(
      key: key,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () async {
          // 재생목록 영상 로드
          try {
            await ref.read(playlistsProvider.notifier).fetchPlaylistVideos(playlist.id);

            if (mounted) {
              final state = ref.read(playlistsProvider);

              // 바텀시트로 열기
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                barrierColor: Colors.black.withValues(alpha: 0.5),
                builder: (context) => PlaylistVideosScreen(
                  playlistId: playlist.id,
                  playlistTitle: playlist.title,
                  videos: state.playlistVideos,
                ),
              );

              // 화면 복귀 시 선택 해제
              ref.read(playlistsProvider.notifier).clearSelectedPlaylist();
            }
          } catch (e) {
            if (mounted) {
              Helpers.showSnackBar(
                context,
                Helpers.getErrorMessage(e, context),
                isError: true,
              );
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 드래그 핸들
              if (showDragHandle) ...[
                ReorderableDragStartListener(
                  index: ref.read(playlistsProvider).playlists.indexOf(playlist),
                  child: const Icon(Icons.drag_handle, color: Colors.grey),
                ),
                const SizedBox(width: 8),
              ],
              // 썸네일
              if (playlist.thumbnailUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    playlist.thumbnailUrl!,
                    width: 120,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 120,
                        height: 90,
                        color: Colors.grey[300],
                        child: const Icon(Icons.playlist_play, size: 48),
                      );
                    },
                  ),
                )
              else
                Container(
                  width: 120,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.playlist_play, size: 48),
                ),
              const SizedBox(width: 12),
              // 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playlist.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)!.videoCount(playlist.itemCount),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (playlist.publishedAt != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        _formatPublishedDate(context, playlist.publishedAt!),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
