import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/channels_provider.dart';
import '../../providers/collections_provider.dart';
import '../../providers/settings_provider.dart';
import '../../models/collection.dart';
import '../../models/channel.dart';
import '../../widgets/channel_card.dart';
import '../../widgets/collection_chip.dart';
import '../../utils/helpers.dart';
import '../../utils/constants.dart';
import '../../utils/extensions.dart';
import '../../l10n/app_localizations.dart';
import '../collections/collection_manage_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _chipScrollController = ScrollController();
  final ScrollController _listScrollController = ScrollController();
  final Map<String, double> _scrollPositions = {}; // 폴더별 스크롤 위치 저장
  String? _pendingScrollCollectionId; // 스크롤 복원 대기 중인 폴더 ID
  String _searchQuery = '';
  bool _isMultiSelectMode = false;
  final Set<String> _selectedChannelIds = {};
  final Map<String, int> _collectionChannelCounts = {};
  int _totalChannelCount = 0;

  // 폴더 전환 슬라이드 애니메이션
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  bool _slideFromRight = true; // true: 오른쪽에서, false: 왼쪽에서

  @override
  bool get wantKeepAlive => true;

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

    // 위젯 빌드 완료 후 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });

    // 채널 변경 감지하여 컬렉션 카운트 업데이트 및 스크롤 복원
    ref.listenManual(channelsProvider, (previous, next) {
      if (previous?.channels.length != next.channels.length) {
        _loadCollectionChannelCounts();
      }
      // 로딩 완료 시 대기 중인 스크롤 위치 복원
      if (previous?.isLoading == true && next.isLoading == false && _pendingScrollCollectionId != null) {
        final collectionId = _pendingScrollCollectionId;
        _pendingScrollCollectionId = null;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_listScrollController.hasClients) {
            final savedPosition = _scrollPositions[collectionId ?? 'all'] ?? 0.0;
            final maxScroll = _listScrollController.position.maxScrollExtent;
            _listScrollController.jumpTo(savedPosition.clamp(0.0, maxScroll));
          }
        });
      }
    });
  }

  Future<void> _loadData() async {
    await ref.read(channelsProvider.notifier).loadChannels();
    await ref.read(collectionsProvider.notifier).loadCollections();

    // 구독이 체크 안되어 있으면 첫 번째 체크된 폴더 선택
    final swipeEnabledIds = await ref.read(swipeEnabledCollectionsProvider.notifier).ensureLoaded();
    if (!swipeEnabledIds.contains(Constants.allChannelsFilterId) && swipeEnabledIds.isNotEmpty) {
      final collectionsState = ref.read(collectionsProvider);
      // 체크된 폴더 중 첫 번째 찾기
      for (final collection in collectionsState.collections) {
        if (swipeEnabledIds.contains(collection.id)) {
          ref.read(channelsProvider.notifier).setSelectedCollection(collection.id);
          break;
        }
      }
    }

    // 각 컬렉션의 채널 수 계산
    await _loadCollectionChannelCounts();

    // 채널이 없으면 구독 가져오기 팝업 표시
    if (mounted && _totalChannelCount == 0) {
      _showFetchSubscriptionsDialog();
    }
    // 채널은 있지만 컬렉션이 없으면 컬렉션 생성 팝업 표시
    else if (mounted && _totalChannelCount > 0) {
      final collectionsState = ref.read(collectionsProvider);
      // 설정이 로드될 때까지 대기
      final hideDialog = await ref.read(hideCreateCollectionDialogProvider.notifier).ensureLoaded();
      if (collectionsState.collections.isEmpty && !hideDialog) {
        _showCreateCollectionDialog();
      }
    }
  }

  Future<void> _showFetchSubscriptionsDialog() async {
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.fetchSubscriptionsTitle),
        content: Text(l10n.fetchSubscriptionsMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.fetchSubscriptionsNo),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.fetchSubscriptionsYes),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      await _handleRefresh();
      // 채널 가져오기 후 컬렉션이 없으면 컬렉션 생성 팝업 표시
      if (mounted && _totalChannelCount > 0) {
        final collectionsState = ref.read(collectionsProvider);
        // 설정이 로드될 때까지 대기
        final hideDialog = await ref.read(hideCreateCollectionDialogProvider.notifier).ensureLoaded();
        if (collectionsState.collections.isEmpty && !hideDialog) {
          _showCreateCollectionDialog();
        }
      }
    }
  }

  Future<void> _showCreateCollectionDialog() async {
    final l10n = AppLocalizations.of(context)!;
    bool dontShowAgain = false;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.createFolderDialogTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.createFolderDialogMessage),
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: dontShowAgain,
                      onChanged: (value) {
                        setDialogState(() {
                          dontShowAgain = value ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setDialogState(() {
                          dontShowAgain = !dontShowAgain;
                        });
                      },
                      child: Text(
                        l10n.createFolderDialogDontShowAgain,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // 다음부터 안보기 체크 시 저장 후 안내 메시지 표시
                if (dontShowAgain) {
                  ref.read(hideCreateCollectionDialogProvider.notifier).setHide(true);
                  Navigator.pop(context, false);
                  // 안내 팝업 표시
                  showDialog(
                    context: this.context,
                    builder: (context) => AlertDialog(
                      content: Text(l10n.createFolderDialogManualGuide),
                      actions: [
                        FilledButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(l10n.confirm),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.pop(context, false);
                }
              },
              child: Text(l10n.createFolderDialogNo),
            ),
            FilledButton(
              onPressed: () {
                // 다음부터 안보기 체크 시 저장
                if (dontShowAgain) {
                  ref.read(hideCreateCollectionDialogProvider.notifier).setHide(true);
                }
                Navigator.pop(context, true);
              },
              child: Text(l10n.createFolderDialogYes),
            ),
          ],
        ),
      ),
    );

    if (result == true && mounted) {
      // 컬렉션 관리 화면으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const CollectionManageScreen(),
        ),
      );
    }
  }

  Future<void> _loadCollectionChannelCounts() async {
    final collectionsState = ref.read(collectionsProvider);
    final db = ref.read(databaseServiceProvider);

    // 전체 채널 수 로드
    final allChannels = await db.getAllChannels();
    setState(() {
      _totalChannelCount = allChannels.length;
    });

    // 각 컬렉션의 채널 수 로드
    for (final collection in collectionsState.collections) {
      final channels = await db.getChannelsInCollection(collection.id);
      setState(() {
        _collectionChannelCounts[collection.id] = channels.length;
      });
    }
  }

  Future<void> _handleRefresh() async {
    try {
      await ref.read(channelsProvider.notifier).refreshSubscriptions();
      // 컬렉션 채널 카운트도 업데이트
      await _loadCollectionChannelCounts();
      if (mounted) {
        Helpers.showSnackBar(context, AppLocalizations.of(context)!.channelsUpdated);
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

  /// 기본 채널 섹션 선택 다이얼로그
  Future<void> _showDefaultSectionDialog() async {
    final currentSection = ref.read(defaultChannelSectionProvider);
    final l10n = AppLocalizations.of(context)!;

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.settingsDefaultChannelSection),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: ChannelSection.values.map((section) {
              return RadioListTile<ChannelSection>(
                title: Text(section.getDisplayName(context)),
                value: section,
                groupValue: currentSection,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(defaultChannelSectionProvider.notifier).setDefaultSection(value);
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

  /// 컬렉션 보기 설정 다이얼로그
  Future<void> _showCollectionViewDialog() async {
    final l10n = AppLocalizations.of(context)!;

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.settingsFolderView),
        content: Consumer(
          builder: (context, ref, child) {
            final isSingleLine = ref.watch(chipLayoutSingleLineProvider);
            final showChannelCount = ref.watch(showCollectionChannelCountProvider);
            final isLarge = ref.watch(collectionSizeLargeProvider);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 한줄/줄바꿈
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(isSingleLine
                      ? l10n.settingsChipLayoutSingleLine
                      : l10n.settingsChipLayoutWrap),
                  value: isSingleLine,
                  onChanged: (value) {
                    ref.read(chipLayoutSingleLineProvider.notifier).setChipLayoutSingleLine(value);
                  },
                ),
                // 채널수 보기
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.settingsShowChannelCount),
                  value: showChannelCount,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(showCollectionChannelCountProvider.notifier).setShowChannelCount(value);
                    }
                  },
                ),
                // 크게/작게
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(isLarge
                      ? l10n.settingsFolderSizeLarge
                      : l10n.settingsFolderSizeSmall),
                  value: isLarge,
                  onChanged: (value) {
                    ref.read(collectionSizeLargeProvider.notifier).setLarge(value);
                  },
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

  void _toggleMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) {
        _selectedChannelIds.clear();
      }
    });
  }

  void _toggleChannelSelection(String channelId) {
    setState(() {
      if (_selectedChannelIds.contains(channelId)) {
        _selectedChannelIds.remove(channelId);
      } else {
        _selectedChannelIds.add(channelId);
      }
    });
  }

  void _selectAll(List<Channel> channels) {
    setState(() {
      // 모든 채널이 선택되어 있는지 확인
      final allChannelIds = channels.map((c) => c.id).toSet();
      final isAllSelected = allChannelIds.every((id) => _selectedChannelIds.contains(id));

      if (isAllSelected) {
        // 전체 해제
        _selectedChannelIds.clear();
      } else {
        // 전체 선택
        _selectedChannelIds.clear();
        _selectedChannelIds.addAll(allChannelIds);
      }
    });
  }

  Future<void> _deleteSelectedChannels() async {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedChannelIds.isEmpty) {
      Helpers.showSnackBar(context, l10n.pleaseSelectChannels, isError: true);
      return;
    }

    final channelsState = ref.read(channelsProvider);
    final selectedCollectionId = channelsState.selectedCollectionId;
    final isInAllChannels =
        selectedCollectionId == null || selectedCollectionId == 'all';

    String title;
    String content;

    if (isInAllChannels) {
      title = l10n.deleteChannel;
      content = l10n.deleteChannelsConfirm(_selectedChannelIds.length);
    } else {
      title = l10n.removeFromFolder;
      content = l10n.removeChannelsConfirm(_selectedChannelIds.length);
    }

    final confirm = await Helpers.showConfirmDialog(
      context,
      title: title,
      content: content,
    );

    if (confirm) {
      try {
        int successCount = 0;
        for (final channelId in _selectedChannelIds) {
          try {
            if (isInAllChannels) {
              // 전체 목록에서 완전 삭제
              await ref.read(channelsProvider.notifier).deleteChannel(channelId);
            } else {
              // 컬렉션에서만 제거
              await ref
                  .read(channelsProvider.notifier)
                  .removeFromCollection(channelId, selectedCollectionId);
            }
            successCount++;
          } catch (e) {
            // 개별 삭제 실패는 무시
          }
        }

        // 컬렉션에서 제거한 경우 목록 새로고침
        if (!isInAllChannels) {
          await ref
              .read(channelsProvider.notifier)
              .loadChannelsInCollection(selectedCollectionId);
        }

        // 컬렉션 채널 수 업데이트
        await _loadCollectionChannelCounts();

        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          Helpers.showSnackBar(
            context,
            isInAllChannels ? l10n.channelsDeleted(successCount) : l10n.channelsRemoved(successCount),
          );
          setState(() {
            _isMultiSelectMode = false;
            _selectedChannelIds.clear();
          });
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

  Future<void> _addSelectedToCollection() async {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedChannelIds.isEmpty) {
      Helpers.showSnackBar(context, l10n.pleaseSelectChannels, isError: true);
      return;
    }

    final collectionsState = ref.read(collectionsProvider);
    if (collectionsState.collections.isEmpty) {
      Helpers.showSnackBar(context, l10n.createFolderFirst, isError: true);
      return;
    }

    final selectedCollection = await showDialog<Collection>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.addToFolder,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.channelsSelected(_selectedChannelIds.length),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 컬렉션 리스트
                Expanded(
                  child: ListView.builder(
                    itemCount: collectionsState.collections.length,
                    itemBuilder: (context, index) {
                      final collection = collectionsState.collections[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.pop(context, collection),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.grey.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
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
      int successCount = 0;
      for (final channelId in _selectedChannelIds) {
        try {
          await ref
              .read(channelsProvider.notifier)
              .addToCollection(channelId, selectedCollection.id);
          successCount++;
        } catch (e) {
          // 이미 추가된 채널은 무시
        }
      }

      // 컬렉션 채널 수 업데이트
      await _loadCollectionChannelCounts();

      if (mounted) {
        Helpers.showSnackBar(
          context,
          AppLocalizations.of(context)!.channelsAddedTo(successCount, selectedCollection.name),
        );
        setState(() {
          _isMultiSelectMode = false;
          _selectedChannelIds.clear();
        });
      }
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    ref.read(channelsProvider.notifier).reorderChannels(oldIndex, newIndex);
  }

  void _scrollToSelectedChip(int collectionsLength, String? selectedCollectionId) {
    if (!_chipScrollController.hasClients) return;

    // 선택된 칩의 인덱스 찾기 (0 = 구독중, 1~ = 컬렉션들)
    int selectedIndex = 0;
    if (selectedCollectionId != null && selectedCollectionId != Constants.allChannelsFilterId) {
      final collections = ref.read(collectionsProvider).collections;
      final index = collections.indexWhere((c) => c.id == selectedCollectionId);
      if (index != -1) {
        selectedIndex = index + 1; // 구독중 칩 다음부터
      }
    }

    // 각 칩의 평균 너비 (텍스트 길이에 따라 다르지만 대략 100-150)
    const double chipWidth = 120.0;
    const double chipSpacing = 8.0;
    const double padding = 12.0;

    // 스크롤할 위치 계산
    final double targetScroll = (selectedIndex * (chipWidth + chipSpacing)) - padding;

    // 화면 중앙에 오도록 조정
    final double screenWidth = MediaQuery.of(context).size.width;
    final double centeredScroll = targetScroll - (screenWidth / 2) + (chipWidth / 2);

    // 스크롤 범위 확인
    final double maxScroll = _chipScrollController.position.maxScrollExtent;
    final double scrollPosition = centeredScroll.clamp(0.0, maxScroll);

    _chipScrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// 폴더 전환 슬라이드 애니메이션 트리거
  void _triggerSlideAnimation({required bool fromRight}) {
    setState(() {
      _slideFromRight = fromRight;
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

  /// 폴더 변경 시 스크롤 위치 저장 및 복원 예약
  void _switchCollection(String? currentId, String? newId) {
    // 현재 폴더의 스크롤 위치 저장
    if (_listScrollController.hasClients) {
      _scrollPositions[currentId ?? 'all'] = _listScrollController.offset;
    }
    // 새 폴더의 스크롤 복원 예약 (로딩 완료 시 listenManual에서 처리)
    _pendingScrollCollectionId = newId ?? 'all';
  }

  @override
  void dispose() {
    _slideController.dispose();
    _searchController.dispose();
    _chipScrollController.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  Widget _buildChipList(
    WidgetRef ref,
    ChannelsState channelsState,
    CollectionsState collectionsState,
  ) {
    final isSingleLine = ref.watch(chipLayoutSingleLineProvider);
    final showChannelCount = ref.watch(showCollectionChannelCountProvider);
    final isLarge = ref.watch(collectionSizeLargeProvider);
    final l10n = AppLocalizations.of(context)!;

    final chips = [
      // 구독중 칩 (항상 표시)
      CollectionChipWidget(
        label: l10n.allChannelsFilter,
        isSelected: channelsState.selectedCollectionId == null ||
            channelsState.selectedCollectionId == Constants.allChannelsFilterId,
        channelCount: _totalChannelCount,
        showChannelCount: showChannelCount,
        isLarge: isLarge,
        onTap: () {
          _switchCollection(channelsState.selectedCollectionId, null);
          ref.read(channelsProvider.notifier).setSelectedCollection(null);
        },
      ),
      // 컬렉션 칩들
      ...collectionsState.collections.map(
        (collection) => CollectionChipWidget(
          label: collection.name,
          color: collection.color,
          isSelected: channelsState.selectedCollectionId == collection.id,
          channelCount: _collectionChannelCounts[collection.id],
          showChannelCount: showChannelCount,
          isLarge: isLarge,
          onTap: () {
            _switchCollection(channelsState.selectedCollectionId, collection.id);
            ref.read(channelsProvider.notifier).setSelectedCollection(collection.id);
          },
        ),
      ),
    ];

    if (isSingleLine) {
      // 한줄 모드: 가로 스크롤
      // 선택된 칩으로 스크롤
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelectedChip(collectionsState.collections.length, channelsState.selectedCollectionId);
      });

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SingleChildScrollView(
          controller: _chipScrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
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
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin 필수
    final channelsState = ref.watch(channelsProvider);
    final collectionsState = ref.watch(collectionsProvider);
    // 설정 변경 시 즉시 반영을 위해 build에서 직접 watch
    ref.watch(chipLayoutSingleLineProvider);
    ref.watch(defaultChannelSectionProvider);
    ref.watch(showCollectionChannelCountProvider);
    ref.watch(collectionSizeLargeProvider);
    final channelTapAction = ref.watch(channelTapActionProvider);

    // 검색 필터링
    final filteredChannels = _searchQuery.isEmpty
        ? channelsState.channels
        : channelsState.channels
            .where((channel) =>
                channel.title.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    final showCollectionFab = ref.watch(showCollectionFabProvider);
    // 구독 칩이 선택된 경우에만 FAB 표시
    final isSubscribedChipSelected = channelsState.selectedCollectionId == null ||
        channelsState.selectedCollectionId == Constants.allChannelsFilterId;

    return Scaffold(
      // 플로팅 버튼: 설정 켜짐 + 구독 칩 선택 시에만 표시
      floatingActionButton: showCollectionFab == true && isSubscribedChipSelected
          ? Container(
              margin: const EdgeInsets.only(bottom: 100),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE53935),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE53935).withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CollectionManageScreen(),
                      ),
                    );
                  },
                  customBorder: const CircleBorder(),
                  child: const Center(
                    child: Icon(Icons.create_new_folder, color: Colors.white, size: 24),
                  ),
                ),
              ),
            )
          : null,
      appBar: AppBar(
        title: _isMultiSelectMode
            ? Text(AppLocalizations.of(context)!.itemsSelected(_selectedChannelIds.length))
            : Text(AppLocalizations.of(context)!.navChannels),
        leading: _isMultiSelectMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _toggleMultiSelectMode,
              )
            : null,
        actions: _isMultiSelectMode
            ? [
                IconButton(
                  icon: const Icon(Icons.select_all),
                  tooltip: AppLocalizations.of(context)!.selectAll,
                  onPressed: () => _selectAll(filteredChannels),
                ),
                IconButton(
                  icon: const Icon(Icons.create_new_folder),
                  tooltip: AppLocalizations.of(context)!.addToFolder,
                  onPressed: _addSelectedToCollection,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: AppLocalizations.of(context)!.delete,
                  onPressed: _deleteSelectedChannels,
                ),
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.checklist),
                  tooltip: AppLocalizations.of(context)!.multiSelect,
                  onPressed: _toggleMultiSelectMode,
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // 검색 다이얼로그 표시
                    showSearch(
                      context: context,
                      delegate: ChannelSearchDelegate(
                        onChannelAddedToCollection: _loadCollectionChannelCounts,
                      ),
                    );
                  },
                ),
                // 정렬 토글 버튼
                IconButton(
                  icon: Icon(
                    channelsState.isSortedAlphabetically
                        ? Icons.sort_by_alpha
                        : Icons.swap_vert,
                  ),
                  tooltip: channelsState.isSortedAlphabetically
                      ? AppLocalizations.of(context)!.alphabetical
                      : AppLocalizations.of(context)!.customOrder,
                  onPressed: () async {
                    await ref.read(channelsProvider.notifier).toggleSortMode();
                  },
                ),
                // 점 세 개 메뉴
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == 'refresh') {
                      if (!channelsState.isLoading) {
                        _handleRefresh();
                      }
                    } else if (value == 'collection_manage') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CollectionManageScreen(),
                        ),
                      );
                    } else if (value == 'toggle_fab') {
                      ref.read(showCollectionFabProvider.notifier).toggle();
                    } else if (value == 'collection_view') {
                      _showCollectionViewDialog();
                    } else if (value == 'default_section') {
                      _showDefaultSectionDialog();
                    } else if (value == 'channel_tap_action') {
                      // 토글: 앱에서 보기 <-> 유튜브에서 열기
                      final current = ref.read(channelTapActionProvider);
                      final newAction = current == ChannelTapAction.latestVideos
                          ? ChannelTapAction.openYoutube
                          : ChannelTapAction.latestVideos;
                      ref.read(channelTapActionProvider.notifier).setChannelTapAction(newAction);
                    } else if (value == 'settings') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    // 구독 새로고침
                    PopupMenuItem<String>(
                      value: 'refresh',
                      enabled: !channelsState.isLoading,
                      child: Row(
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 20,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Text(AppLocalizations.of(context)!.refreshSubscriptions),
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'collection_manage',
                      child: Row(
                        children: [
                          Icon(Icons.folder_outlined, size: 20, color: Colors.grey[400]),
                          const SizedBox(width: 12),
                          Text(AppLocalizations.of(context)!.folderManage),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'collection_view',
                      child: Row(
                        children: [
                          Icon(
                            Icons.view_list,
                            size: 20,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 12),
                          Text(AppLocalizations.of(context)!.settingsFolderView),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'toggle_fab',
                      child: Row(
                        children: [
                          Icon(
                            showCollectionFab == true ? Icons.visibility_off : Icons.visibility,
                            size: 20,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Text(
                              showCollectionFab == true
                                  ? AppLocalizations.of(context)!.hideFolderFab
                                  : AppLocalizations.of(context)!.showFolderFab,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'channel_tap_action',
                      child: Row(
                        children: [
                          Icon(Icons.touch_app, size: 20, color: Colors.grey[400]),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Text(
                              channelTapAction == ChannelTapAction.openYoutube
                                  ? AppLocalizations.of(context)!.settingsChannelTapOpenYoutube
                                  : AppLocalizations.of(context)!.settingsChannelTapLatestVideos,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.swap_horiz, size: 16, color: Colors.grey[400]),
                        ],
                      ),
                    ),
                    // 기본 채널 섹션
                    PopupMenuItem<String>(
                      value: 'default_section',
                      child: Row(
                        children: [
                          Icon(Icons.tab, size: 20, color: Colors.grey[400]),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Text(AppLocalizations.of(context)!.settingsDefaultChannelSection),
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    // 설정
                    PopupMenuItem<String>(
                      value: 'settings',
                      child: Row(
                        children: [
                          Icon(Icons.settings, size: 20, color: Colors.grey[400]),
                          const SizedBox(width: 12),
                          Text(AppLocalizations.of(context)!.navSettings),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
      ),
      body: Column(
        children: [
          // 컬렉션 필터 칩
          _buildChipList(
            ref,
            channelsState,
            collectionsState,
          ),

          // 채널 리스트 (좌우 스와이프로 컬렉션 이동)
          Expanded(
            child: GestureDetector(
              onHorizontalDragEnd: (details) async {
                if (details.primaryVelocity == null) return;

                // 스와이프 활성화된 컬렉션만 필터링 (로딩 완료 대기)
                final swipeEnabledIds = await ref.read(swipeEnabledCollectionsProvider.notifier).ensureLoaded();

                // 전체 컬렉션 목록 (순서 유지)
                final allCollections = collectionsState.collections;

                // 현재 선택된 컬렉션
                final currentId = channelsState.selectedCollectionId ?? Constants.allChannelsFilterId;

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
                    _switchCollection(channelsState.selectedCollectionId, nextId);
                    ref.read(channelsProvider.notifier).setSelectedCollection(nextId);
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
                    _switchCollection(channelsState.selectedCollectionId, prevId);
                    ref.read(channelsProvider.notifier).setSelectedCollection(prevId);
                  } else if (currentPositionInAll >= 0 && (swipeEnabledIds.isEmpty || swipeEnabledIds.contains(Constants.allChannelsFilterId))) {
                    // 이전 스와이프 활성화 컬렉션이 없고 (체크된게 없거나 구독이 체크되어 있으면) 구독으로 이동
                    _triggerSlideAnimation(fromRight: false);
                    _switchCollection(channelsState.selectedCollectionId, null);
                    ref.read(channelsProvider.notifier).setSelectedCollection(null);
                  } else if (currentNavIndex > 0) {
                    // 구독이 체크 안되어 있거나 구독에서 오른쪽 스와이프하면 이전 네비게이션 메뉴로 이동
                    ref.read(currentNavIndexProvider.notifier).state = currentNavIndex - 1;
                  }
                }
              },
              child: channelsState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SlideTransition(
                      position: _slideAnimation,
                      child: filteredChannels.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.subscriptions,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchQuery.isEmpty
                                  ? AppLocalizations.of(context)!.noSubscriptions
                                  : AppLocalizations.of(context)!.noSearchResults,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : _isMultiSelectMode
                        ? ListView.builder(
                            controller: _listScrollController,
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).padding.bottom + 80,
                            ),
                            itemCount: filteredChannels.length,
                            itemBuilder: (context, index) {
                              final channel = filteredChannels[index];
                              final isSelected =
                                  _selectedChannelIds.contains(channel.id);

                              return CheckboxListTile(
                                key: ValueKey(channel.id),
                                value: isSelected,
                                onChanged: (value) =>
                                    _toggleChannelSelection(channel.id),
                                secondary: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: channel.thumbnailUrl != null
                                      ? Image.network(
                                          channel.thumbnailUrl!,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          width: 60,
                                          height: 60,
                                          color: Colors.grey[300],
                                          child: const Icon(
                                              Icons.play_circle_outline),
                                        ),
                                ),
                                title: Text(
                                  channel.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: channel.subscriberCount != null
                                    ? Text(
                                        AppLocalizations.of(context)!.subscriberCount(channel.subscriberCount!.toSubscriberCount(context)))
                                    : null,
                              );
                            },
                          )
                        : ReorderableListView.builder(
                                scrollController: _listScrollController,
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).padding.bottom + 80,
                                ),
                                itemCount: filteredChannels.length,
                                onReorder: _onReorder,
                                itemBuilder: (context, index) {
                                  final channel = filteredChannels[index];
                                  return ChannelCard(
                                    key: ValueKey(channel.id),
                                    channel: channel,
                                    onChannelAddedToCollection:
                                        _loadCollectionChannelCounts,
                                  );
                                },
                              ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// 검색 델리게이트
class ChannelSearchDelegate extends SearchDelegate<String> {
  final VoidCallback? onChannelAddedToCollection;

  ChannelSearchDelegate({this.onChannelAddedToCollection});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final channelsState = ref.watch(channelsProvider);
        final channels = channelsState.channels;

        final filteredChannels = query.isEmpty
            ? channels
            : channels
                .where((channel) =>
                    channel.title.toLowerCase().contains(query.toLowerCase()))
                .toList();

        return ListView.builder(
          itemCount: filteredChannels.length,
          itemBuilder: (context, index) {
            final channel = filteredChannels[index];
            return ChannelCard(
              key: ValueKey(channel.id),
              channel: channel,
              onChannelAddedToCollection: onChannelAddedToCollection,
            );
          },
        );
      },
    );
  }
}
