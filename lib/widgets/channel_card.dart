import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../l10n/app_localizations.dart';
import '../models/channel.dart';
import '../models/collection.dart';
import '../utils/extensions.dart';
import '../utils/helpers.dart';
import '../config/theme.dart';
import '../providers/collections_provider.dart';
import '../providers/channels_provider.dart';
import '../providers/settings_provider.dart';
import '../screens/videos/channel_videos_screen.dart';

class ChannelCard extends ConsumerWidget {
  final Channel channel;
  final VoidCallback? onChannelAddedToCollection;

  const ChannelCard({
    super.key,
    required this.channel,
    this.onChannelAddedToCollection,
  });

  /// 유튜브에서 채널 열기
  Future<void> _openInYoutube(BuildContext context, WidgetRef ref) async {
    // 채널별 섹션 설정 또는 기본 섹션 사용
    final section = channel.defaultSection != null
        ? ChannelSectionExtension.fromString(channel.defaultSection)
        : ref.read(defaultChannelSectionProvider);

    final sectionPath = section.urlPath;
    final url = Uri.parse(
      'https://www.youtube.com/channel/${channel.id}$sectionPath',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        Helpers.showSnackBar(context, AppLocalizations.of(context)!.cannotOpenChannel, isError: true);
      }
    }
  }

  /// 최신 영상 화면으로 이동 (Bottom Sheet)
  void _openLatestVideos(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => ChannelVideosScreen(
        channelId: channel.id,
        channelTitle: channel.title,
        channelThumbnailUrl: channel.thumbnailUrl,
      ),
    );
  }

  /// 채널 탭 액션 실행 (설정에 따라)
  void _handleChannelTap(BuildContext context, WidgetRef ref) {
    final tapAction = ref.read(channelTapActionProvider);
    if (tapAction == ChannelTapAction.latestVideos) {
      _openLatestVideos(context);
    } else {
      _openInYoutube(context, ref);
    }
  }

  /// 보조 버튼 액션 실행 (설정의 반대 동작)
  void _handleSecondaryAction(BuildContext context, WidgetRef ref) {
    final tapAction = ref.read(channelTapActionProvider);
    if (tapAction == ChannelTapAction.latestVideos) {
      _openInYoutube(context, ref);
    } else {
      _openLatestVideos(context);
    }
  }

  Future<void> _showAddToCollectionDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final collectionsState = ref.read(collectionsProvider);

    if (collectionsState.collections.isEmpty) {
      Helpers.showSnackBar(context, AppLocalizations.of(context)!.createCategoryFirst, isError: true);
      return;
    }

    final selectedCollection = await showDialog<Collection>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 제목
                Row(
                  children: [
                    Icon(
                      Icons.folder_outlined,
                      color: Colors.grey,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.addToFolder,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 컬렉션 리스트 (스크롤 가능)
                Expanded(
                  child: ListView.builder(
                    itemCount: collectionsState.collections.length,
                    itemBuilder: (context, index) {
                      final collection = collectionsState.collections[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.pop(context, collection),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      collection.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (selectedCollection != null) {
      try {
        await ref
            .read(channelsProvider.notifier)
            .addToCollection(channel.id, selectedCollection.id);

        // 콜백 호출하여 컬렉션 카운트 업데이트
        onChannelAddedToCollection?.call();

        if (context.mounted) {
          Helpers.showSnackBar(context, AppLocalizations.of(context)!.addedToFolder(selectedCollection.name));
        }
      } catch (e) {
        if (context.mounted) {
          Helpers.showSnackBar(
            context,
            Helpers.getErrorMessage(e, context),
            isError: true,
          );
        }
      }
    }
  }

  /// 채널 섹션 설정 다이얼로그
  Future<void> _showSectionDialog(BuildContext context, WidgetRef ref) async {
    final defaultSection = ref.read(defaultChannelSectionProvider);

    // 현재 선택된 컬렉션 ID 저장
    final currentCollectionId = ref.read(channelsProvider).selectedCollectionId;

    // 현재 컬렉션에 맞게 채널 목록 새로고침
    Future<void> reloadChannels() async {
      if (currentCollectionId == null || currentCollectionId == 'all') {
        await ref.read(channelsProvider.notifier).loadChannels();
      } else {
        await ref
            .read(channelsProvider.notifier)
            .loadChannelsInCollection(currentCollectionId);
      }
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.sectionSettingsTitle(channel.title),
          style: const TextStyle(fontSize: 16),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 기본값 사용 옵션
              RadioListTile<String?>(
                title: Text(AppLocalizations.of(context)!.useDefaultSection(defaultSection.getDisplayName(context))),
                value: null,
                groupValue: channel.defaultSection,
                onChanged: (value) async {
                  await ref
                      .read(databaseServiceProvider)
                      .updateChannelDefaultSection(channel.id, null);
                  await reloadChannels();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    Helpers.showSnackBar(context, AppLocalizations.of(context)!.sectionSetToDefault);
                  }
                },
              ),
              const Divider(),
              // 각 섹션 옵션
              ...ChannelSection.values.map((section) {
                return RadioListTile<String?>(
                  title: Text(section.getDisplayName(context)),
                  value: section.name,
                  groupValue: channel.defaultSection,
                  onChanged: (value) async {
                    await ref
                        .read(databaseServiceProvider)
                        .updateChannelDefaultSection(channel.id, value);
                    await reloadChannels();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      Helpers.showSnackBar(
                        context,
                        AppLocalizations.of(context)!.sectionSetTo(section.getDisplayName(context)),
                      );
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final channelsState = ref.read(channelsProvider);
    final selectedCollectionId = channelsState.selectedCollectionId;

    // 전체 목록에서 보고 있는지, 특정 컬렉션에서 보고 있는지 확인
    final isInAllChannels =
        selectedCollectionId == null || selectedCollectionId == 'all';

    String title;
    String content;

    if (isInAllChannels) {
      // 구독중 목록: 채널 완전 삭제
      title = l10n.deleteChannel;
      content = l10n.deleteChannelConfirm(channel.title);
    } else {
      // 특정 컬렉션: 컬렉션에서만 제거
      title = l10n.removeFromFolder;
      content = l10n.removeChannelConfirm(channel.title);
    }

    final confirm = await Helpers.showConfirmDialog(
      context,
      title: title,
      content: content,
    );

    if (confirm) {
      try {
        if (isInAllChannels) {
          // 전체 목록에서 완전 삭제
          await ref.read(channelsProvider.notifier).deleteChannel(channel.id);

          // 콜백 호출하여 컬렉션 카운트 업데이트
          onChannelAddedToCollection?.call();

          if (context.mounted) {
            Helpers.showSnackBar(context, AppLocalizations.of(context)!.channelDeleted);
          }
        } else {
          // 컬렉션에서만 제거
          await ref
              .read(channelsProvider.notifier)
              .removeFromCollection(channel.id, selectedCollectionId);

          // 컬렉션 목록 새로고침
          await ref
              .read(channelsProvider.notifier)
              .loadChannelsInCollection(selectedCollectionId);

          // 콜백 호출하여 컬렉션 카운트 업데이트
          onChannelAddedToCollection?.call();

          if (context.mounted) {
            Helpers.showSnackBar(context, AppLocalizations.of(context)!.removedFromFolder);
          }
        }
      } catch (e) {
        if (context.mounted) {
          Helpers.showSnackBar(
            context,
            Helpers.getErrorMessage(e, context),
            isError: true,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelsState = ref.watch(channelsProvider);
    final selectedCollectionId = channelsState.selectedCollectionId;
    final isInAllChannels =
        selectedCollectionId == null || selectedCollectionId == 'all';

    // 구독 여부 확인: isSubscribed 필드 사용
    final isSubscribed = channel.isSubscribed;

    // 카드 크기 설정 (small 고정)
    const thumbnailSize = 48.0;
    const cardPadding = 12.0;
    const titleFontSize = 14.0;
    const subscriberFontSize = 12.0;
    const dateFontSize = 11.0;

    return Card(
      key: ValueKey(channel.id),
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMD,
        vertical: AppTheme.spacingSM,
      ),
      child: InkWell(
        onTap: () => _handleChannelTap(context, ref),
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        child: Padding(
          padding: EdgeInsets.all(cardPadding),
          child: Row(
            children: [
              // 드래그 핸들
              const Icon(Icons.drag_handle, color: Colors.grey),
              const SizedBox(width: AppTheme.spacingMD),

              // 썸네일
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: channel.thumbnailUrl != null
                    ? CachedNetworkImage(
                        imageUrl: channel.thumbnailUrl!,
                        width: thumbnailSize,
                        height: thumbnailSize,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: thumbnailSize,
                          height: thumbnailSize,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: thumbnailSize,
                          height: thumbnailSize,
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        ),
                      )
                    : Container(
                        width: thumbnailSize,
                        height: thumbnailSize,
                        color: Colors.grey[300],
                        child: const Icon(Icons.play_circle_outline),
                      ),
              ),
              const SizedBox(width: AppTheme.spacingMD),

              // 채널 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 채널명과 미구독 뱃지
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            channel.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // 미구독 뱃지 - 컬렉션 내부에서만, 구독 중이 아닌 채널에만 표시
                        if (!isInAllChannels && !isSubscribed) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.circle_outlined,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  AppLocalizations.of(context)!.unsubscribed,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),

                    // 구독자 수
                    if (channel.subscriberCount != null)
                      Text(
                        AppLocalizations.of(context)!.subscriberCount(channel.subscriberCount!.toSubscriberCount(context)),
                        style: TextStyle(
                          fontSize: subscriberFontSize,
                          color: Colors.grey[600],
                        ),
                      ),
                    const SizedBox(height: 1),

                    // 최근 업로드
                    if (channel.lastUploadDate != null)
                      Text(
                        AppLocalizations.of(context)!.uploadedAgo(channel.lastUploadDate!.toRelativeTime(context)),
                        style: TextStyle(
                          fontSize: dateFontSize,
                          color: Colors.grey[500],
                        ),
                      ),
                  ],
                ),
              ),

              // 보조 액션 버튼 (설정의 반대 동작)
              Builder(
                builder: (context) {
                  final tapAction = ref.watch(channelTapActionProvider);
                  final isLatestVideosDefault =
                      tapAction == ChannelTapAction.latestVideos;
                  return IconButton(
                    icon: isLatestVideosDefault
                        ? const FaIcon(
                            FontAwesomeIcons.youtube,
                            size: 24,
                            color: Color(0xFFFF0000),
                          )
                        : ClipOval(
                            child: Image.asset(
                              'assets/icon/top_icon.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                    tooltip: isLatestVideosDefault ? '유튜브에서 열기' : '최신 영상',
                    onPressed: () => _handleSecondaryAction(context, ref),
                  );
                },
              ),

              // 더보기 아이콘
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  switch (value) {
                    case 'collection':
                      _showAddToCollectionDialog(context, ref);
                      break;
                    case 'section':
                      _showSectionDialog(context, ref);
                      break;
                    case 'remove':
                      _handleDelete(context, ref);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'collection',
                    child: Row(
                      children: [
                        const Icon(Icons.create_new_folder, size: 20),
                        const SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.addToFolder),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'section',
                    child: Row(
                      children: [
                        const Icon(Icons.tab, size: 20),
                        const SizedBox(width: 8),
                        Text(AppLocalizations.of(context)!.sectionSettings),
                      ],
                    ),
                  ),
                  if (!isInAllChannels)
                    PopupMenuItem(
                      value: 'remove',
                      child: Row(
                        children: [
                          const Icon(Icons.remove_circle_outline, size: 20, color: Colors.red),
                          const SizedBox(width: 8),
                          Text(AppLocalizations.of(context)!.removeFromFolder, style: const TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
