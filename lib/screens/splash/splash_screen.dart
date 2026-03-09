import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/channels_provider.dart';
import '../login/login_screen.dart';
import '../main_navigation_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();

    // 슬라이드 애니메이션 설정
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // 로고: 위에서 아래로
    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    // 텍스트: 아래에서 위로
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    // 애니메이션 시작
    _controller.forward();

    _checkAuthStatus();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkAuthStatus() async {
    // 로고 표시 시간 (최소 1초)
    await Future.delayed(const Duration(seconds: 1));

    // 인증 상태 초기화
    await ref.read(authStateProvider.notifier).initialize();

    if (!mounted) return;

    // 인증 상태에 따라 화면 이동
    final authState = ref.read(authStateProvider);
    if (authState.isAuthenticated) {
      // 사용자별 DB로 전환
      if (authState.userEmail != null) {
        await ref.read(databaseServiceProvider).setCurrentUser(authState.userEmail);
      }
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 앱 아이콘 (위에서 내려옴)
            SlideTransition(
              position: _logoSlideAnimation,
              child: Image.asset(
                'assets/icon/td800t.png',
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 2),
            // 텍스트 (아래에서 올라옴)
            SlideTransition(
              position: _textSlideAnimation,
              child: Text(
                'TubeDeck',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE53935),
                      shadows: [
                        Shadow(
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black.withValues(alpha: 0.3),
                        ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
