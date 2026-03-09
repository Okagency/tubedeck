import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/settings_provider.dart';

class NavOrderScreen extends ConsumerStatefulWidget {
  const NavOrderScreen({super.key});

  @override
  ConsumerState<NavOrderScreen> createState() => _NavOrderScreenState();
}

class _NavOrderScreenState extends ConsumerState<NavOrderScreen> {
  late List<NavItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(ref.read(navOrderProvider));
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
    // 순서 변경 시 바로 저장
    ref.read(navOrderProvider.notifier).setNavOrder(_items);
  }

  Future<void> _resetOrder() async {
    setState(() {
      _items = List.from(NavOrderNotifier.defaultOrder);
    });
    // 초기화 시 바로 저장
    await ref.read(navOrderProvider.notifier).setNavOrder(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메뉴 순서'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '기본값으로 초기화',
            onPressed: _resetOrder,
          ),
        ],
      ),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _items.length,
        onReorder: _onReorder,
        itemBuilder: (context, index) {
          final item = _items[index];
          return Card(
            key: ValueKey(item),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: Icon(item.icon, color: Colors.grey),
              title: Text(
                item.getDisplayName(context),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.drag_handle, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
