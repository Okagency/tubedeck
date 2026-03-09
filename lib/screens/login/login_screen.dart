import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/channels_provider.dart';
import '../../providers/collections_provider.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/playlists_provider.dart';
import '../../utils/helpers.dart';
import '../../l10n/app_localizations.dart';
import '../main_navigation_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);

    try {
      final success = await ref.read(authStateProvider.notifier).signIn();

      if (!mounted) return;

      if (success) {
        // 로그인 성공 - YouTube 구독 채널 가져오기
        Helpers.showLoadingDialog(context, message: AppLocalizations.of(context)!.loadingSubscriptions);

        try {
          // 새 사용자의 DB로 전환 (Provider의 DatabaseService도 강제 동기화)
          final userEmail = ref.read(authStateProvider).userEmail;
          await ref.read(databaseServiceProvider).setCurrentUser(userEmail, force: true);

          // 기존 데이터 초기화 (다른 계정 데이터 제거)
          ref.read(channelsProvider.notifier).clear();
          ref.read(collectionsProvider.notifier).clear();
          ref.read(favoritesProvider.notifier).clear();
          ref.read(playlistsProvider.notifier).clear();

          // 채널, 컬렉션, 즐겨찾기 로드
          await ref
              .read(channelsProvider.notifier)
              .fetchSubscriptionsFromYouTube();
          await ref.read(collectionsProvider.notifier).loadCollections();
          await ref.read(favoritesProvider.notifier).loadFavorites();

          if (!mounted) return;
          Helpers.hideLoadingDialog(context);

          // Home 화면으로 이동
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
          );
        } catch (e) {
          if (!mounted) return;
          Helpers.hideLoadingDialog(context);
          Helpers.showSnackBar(
            context,
            Helpers.getErrorMessage(e, context),
            isError: true,
          );
        }
      } else {
        final authState = ref.read(authStateProvider);
        Helpers.showSnackBar(
          context,
          authState.errorMessage ?? AppLocalizations.of(context)!.loginFailed,
          isError: true,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // 로고
              Image.asset(
                'assets/icon/td800t.png',
                width: 180,
                height: 180,
              ),
              const SizedBox(height: 2),

              // 타이틀
              Text(
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
              const SizedBox(height: 8),

              // 부제목
              Text(
                AppLocalizations.of(context)!.loginSubtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
              ),

              const Spacer(),

              // Google 로그인 버튼
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _handleGoogleSignIn,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.login),
                  label: Text(
                    _isLoading
                        ? AppLocalizations.of(context)!.loggingIn
                        : AppLocalizations.of(context)!.loginWithGoogle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 안내 문구
              Text(
                AppLocalizations.of(context)!.loginPermissionNotice,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
