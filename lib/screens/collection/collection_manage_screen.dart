import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/collection.dart';
import '../../providers/collections_provider.dart';
import '../../config/theme.dart';
import '../../utils/helpers.dart';
import '../../l10n/app_localizations.dart';

class CollectionManageScreen extends ConsumerStatefulWidget {
  const CollectionManageScreen({super.key});

  @override
  ConsumerState<CollectionManageScreen> createState() =>
      _CollectionManageScreenState();
}

class _CollectionManageScreenState
    extends ConsumerState<CollectionManageScreen> {
  Map<String, int> _channelCounts = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    await ref.read(collectionsProvider.notifier).loadCollections();
    await _loadChannelCounts();
  }

  Future<void> _loadChannelCounts() async {
    final collections = ref.read(collectionsProvider).collections;
    final counts = <String, int>{};

    for (final collection in collections) {
      counts[collection.id] =
          await ref.read(collectionsProvider.notifier).getChannelCount(collection.id);
    }

    if (mounted) {
      setState(() {
        _channelCounts = counts;
      });
    }
  }

  Future<void> _showCreateCollectionDialog() async {
    final TextEditingController nameController = TextEditingController();
    Color selectedColor = AppTheme.primaryPurple;
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<Map<String, dynamic>?>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.folderCreate),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: l10n.folderName,
                  border: const OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  AppTheme.primaryPurple,
                  AppTheme.secondaryPink,
                  AppTheme.accentBlue,
                  AppTheme.accentGreen,
                  AppTheme.accentYellow,
                  Colors.red,
                  Colors.orange,
                  Colors.teal,
                ].map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedColor == color
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  Navigator.pop(context, {
                    'name': nameController.text,
                    'color': selectedColor.toARGB32(),
                  });
                }
              },
              child: Text(l10n.create),
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      try {
        await ref.read(collectionsProvider.notifier).createCollection(
              result['name'] as String,
              result['color'] as int,
            );
        if (mounted) {
          Helpers.showSnackBar(context, l10n.folderCreated);
          await _loadChannelCounts();
        }
      } catch (e) {
        if (mounted) {
          Helpers.showSnackBar(context, Helpers.getErrorMessage(e, context),
              isError: true);
        }
      }
    }
  }

  Future<void> _showEditCollectionDialog(Collection collection) async {
    final TextEditingController nameController =
        TextEditingController(text: collection.name);
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<String?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.folderEdit),
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
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                Navigator.pop(context, nameController.text);
              }
            },
            child: Text(l10n.edit),
          ),
        ],
      ),
    );

    if (result != null) {
      try {
        await ref
            .read(collectionsProvider.notifier)
            .updateCollection(collection.id, result, collection.colorCode);
        if (mounted) {
          Helpers.showSnackBar(context, l10n.folderUpdated);
        }
      } catch (e) {
        if (mounted) {
          Helpers.showSnackBar(context, Helpers.getErrorMessage(e, context),
              isError: true);
        }
      }
    }
  }

  Future<void> _deleteCollection(Collection collection) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: l10n.folderDelete,
      content: l10n.folderDeleteConfirm(collection.name),
    );

    if (confirm) {
      try {
        await ref
            .read(collectionsProvider.notifier)
            .deleteCollection(collection.id);
        if (mounted) {
          Helpers.showSnackBar(context, l10n.folderDeleted);
          await _loadChannelCounts();
        }
      } catch (e) {
        if (mounted) {
          Helpers.showSnackBar(context, Helpers.getErrorMessage(e, context),
              isError: true);
        }
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
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: collectionsState.collections.length,
                  itemBuilder: (context, index) {
                    final collection = collectionsState.collections[index];
                    final channelCount = _channelCounts[collection.id] ?? 0;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: collection.color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.folder,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          collection.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(l10n.channelCount(channelCount)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () =>
                                  _showEditCollectionDialog(collection),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              color: Colors.red,
                              onPressed: () => _deleteCollection(collection),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateCollectionDialog,
        icon: const Icon(Icons.add),
        label: Text(l10n.folderCreateNew),
      ),
    );
  }
}
