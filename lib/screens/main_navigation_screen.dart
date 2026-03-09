import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import 'home/home_screen.dart';
import 'settings/settings_screen.dart';
import 'videos/latest_videos_screen.dart';
import 'playlists/playlists_screen.dart';
import 'favorites/favorites_screen.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  late PageController _pageController;
  bool _isProgrammaticScroll = false; // 프로그래밍 방식 스크롤 중인지 체크

  @override
  void initState() {
    super.initState();
    final currentIndex = ref.read(currentNavIndexProvider);
    _pageController = PageController(initialPage: currentIndex);

    // currentNavIndexProvider 변경 감지
    ref.listenManual(currentNavIndexProvider, (previous, next) {
      if (_pageController.hasClients && previous != next && !_isProgrammaticScroll) {
        _isProgrammaticScroll = true;

        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ).then((_) {
          _isProgrammaticScroll = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// NavItem에 해당하는 스크린 위젯 반환
  Widget _getScreenForNavItem(NavItem item) {
    switch (item) {
      case NavItem.home:
        return const HomeScreen(key: PageStorageKey('home_screen'));
      case NavItem.latestVideos:
        return const LatestVideosScreen(key: PageStorageKey('latest_videos_screen'));
      case NavItem.favorites:
        return const FavoritesScreen(key: PageStorageKey('favorites_screen'));
      case NavItem.playlists:
        return const PlaylistsScreen(key: PageStorageKey('playlists_screen'));
      case NavItem.settings:
        return const SettingsScreen(key: PageStorageKey('settings_screen'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final navOrder = ref.watch(navOrderProvider);
    final currentIndex = ref.watch(currentNavIndexProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // 백버튼 누르면 앱 완전 종료
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          // 프로그래밍 방식 스크롤이 아닐 때만 provider 업데이트 (사용자 스와이프)
          if (!_isProgrammaticScroll) {
            ref.read(currentNavIndexProvider.notifier).state = index;
          }
        },
        children: navOrder.map((item) => _getScreenForNavItem(item)).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.9),
          border: Border(
            top: BorderSide(color: Colors.grey.withValues(alpha: 0.3), width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.grey[600],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          iconSize: 22,
          onTap: (index) {
            ref.read(currentNavIndexProvider.notifier).state = index;
          },
          items: navOrder.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.getDisplayName(context),
            );
          }).toList(),
        ),
      ),
      ),
    );
  }
}
