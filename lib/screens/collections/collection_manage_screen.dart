import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/collections_provider.dart';
import '../../providers/channels_provider.dart';
import '../../providers/settings_provider.dart';
import '../../utils/helpers.dart';
import '../../utils/constants.dart';
import '../../l10n/app_localizations.dart';

class CollectionManageScreen extends ConsumerStatefulWidget {
  const CollectionManageScreen({super.key});

  @override
  ConsumerState<CollectionManageScreen> createState() =>
      _CollectionManageScreenState();
}

class _CollectionManageScreenState
    extends ConsumerState<CollectionManageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(collectionsProvider.notifier).loadCollections();
    });
  }

  Future<void> _showCreateCollectionDialog() async {
    final nameController = TextEditingController();
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.folderCreate),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: l10n.folderName,
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                Navigator.of(context).pop(true);
              }
            },
            child: Text(l10n.create),
          ),
        ],
      ),
    );

    if (result == true && nameController.text.isNotEmpty) {
      await ref
          .read(collectionsProvider.notifier)
          .createCollection(nameController.text, Constants.defaultCollectionColor);
      if (mounted) {
        Helpers.showSnackBar(context, l10n.folderCreated);
      }
    }
  }

  Future<void> _showEditCollectionDialog(String id, String name, int colorCode) async {
    final nameController = TextEditingController(text: name);
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.folderEdit),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: l10n.folderName,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                Navigator.of(context).pop(true);
              }
            },
            child: Text(l10n.edit),
          ),
        ],
      ),
    );

    if (result == true && nameController.text.isNotEmpty) {
      await ref
          .read(collectionsProvider.notifier)
          .updateCollection(id, nameController.text, colorCode);
      if (mounted) {
        Helpers.showSnackBar(context, l10n.folderUpdated);
      }
    }
  }

  Future<void> _deleteCollection(String id, String name) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: l10n.folderDelete,
      content: l10n.folderDeleteConfirm(name),
    );

    if (confirm) {
      // 현재 선택된 컬렉션 확인
      final channelsState = ref.read(channelsProvider);
      final isCurrentlySelected = channelsState.selectedCollectionId == id;

      // 컬렉션 삭제
      await ref.read(collectionsProvider.notifier).deleteCollection(id);

      // 삭제된 컬렉션이 현재 선택되어 있었다면 전체 메뉴로 이동
      if (isCurrentlySelected) {
        ref.read(channelsProvider.notifier).setSelectedCollection(null);
      }

      if (mounted) {
        Helpers.showSnackBar(context, l10n.folderDeleted);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final collectionsState = ref.watch(collectionsProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.folderManage),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showCreateCollectionDialog,
          ),
        ],
      ),
      body: collectionsState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : collectionsState.collections.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.folderEmpty,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _showCreateCollectionDialog,
                        icon: const Icon(Icons.add),
                        label: Text(l10n.folderCreateNew),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n.swipeEnabledDescription,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 구독 항목 (고정, 체크박스만)
                    Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: const SizedBox(width: 24), // 드래그 핸들 자리 (빈 공간)
                        title: Text(
                          l10n.allChannelsFilter,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Checkbox(
                          value: ref.watch(swipeEnabledCollectionsProvider).contains(Constants.allChannelsFilterId),
                          onChanged: (value) {
                            ref.read(swipeEnabledCollectionsProvider.notifier)
                                .toggleCollection(Constants.allChannelsFilterId);
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReorderableListView.builder(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom + 80,
                        ),
                        itemCount: collectionsState.collections.length,
                        onReorder: (oldIndex, newIndex) {
                          ref
                              .read(collectionsProvider.notifier)
                              .reorderCollections(oldIndex, newIndex);
                        },
                        itemBuilder: (context, index) {
                          final collection = collectionsState.collections[index];
                          final swipeEnabled = ref.watch(swipeEnabledCollectionsProvider);
                          final isSwipeEnabled = swipeEnabled.contains(collection.id);
                          return Card(
                            key: ValueKey(collection.id),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.drag_handle, color: Colors.grey),
                              title: Text(
                                collection.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: FutureBuilder<int>(
                                future: ref
                                    .read(collectionsProvider.notifier)
                                    .getChannelCount(collection.id),
                                builder: (context, snapshot) {
                                  final count = snapshot.data ?? 0;
                                  return Text(l10n.channelCount(count));
                                },
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: isSwipeEnabled,
                                    onChanged: (value) {
                                      ref.read(swipeEnabledCollectionsProvider.notifier)
                                          .toggleCollection(collection.id);
                                    },
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _showEditCollectionDialog(
                                      collection.id,
                                      collection.name,
                                      collection.colorCode,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () => _deleteCollection(
                                      collection.id,
                                      collection.name,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
