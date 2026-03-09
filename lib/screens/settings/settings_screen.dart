import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../../providers/settings_provider.dart';
import '../../providers/channels_provider.dart';
import '../../models/channel.dart';
import '../../providers/collections_provider.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/latest_videos_provider.dart';
import '../../providers/playlists_provider.dart';
import '../../providers/locale_provider.dart';
import '../../services/backup_service.dart';
import '../../utils/helpers.dart';
import '../../config/app_config.dart';
import '../../l10n/app_localizations.dart';
import '../login/login_screen.dart';
import 'nav_order_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: l10n.dialogLogoutTitle,
      content: l10n.dialogLogoutContent,
    );

    if (confirm && context.mounted) {
      // 모든 Provider 상태 초기화
      ref.read(channelsProvider.notifier).clear();
      ref.read(collectionsProvider.notifier).clear();
      ref.read(favoritesProvider.notifier).clear();
      ref.read(playlistsProvider.notifier).clear();
      ref.read(latestVideosProvider.notifier).clear();

      // 로그아웃 (DB 연결 해제 포함)
      await ref.read(authStateProvider.notifier).signOut();

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }

  /// 언어 선택 다이얼로그
  Future<void> _showLanguageDialog(BuildContext context, WidgetRef ref) async {
    final currentLocale = ref.read(localeProvider);
    final l10n = AppLocalizations.of(context)!;

    // Get current locale key for comparison (handles zh_TW specially)
    String getCurrentLocaleKey() {
      if (currentLocale == null) return 'system';
      if (currentLocale.countryCode == 'TW') return 'zh_TW';
      return currentLocale.languageCode;
    }

    final currentKey = getCurrentLocaleKey();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsLanguage),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text(l10n.settingsLanguageSystem),
                value: 'system',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setSystemLocale();
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('English'),
                value: 'en',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.english);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('한국어'),
                value: 'ko',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.korean);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('日本語'),
                value: 'ja',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.japanese);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('简体中文'),
                value: 'zh',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.simplifiedChinese);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('繁體中文'),
                value: 'zh_TW',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.traditionalChinese);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Deutsch'),
                value: 'de',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.german);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Français'),
                value: 'fr',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.french);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('ไทย'),
                value: 'th',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.thai);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Tiếng Việt'),
                value: 'vi',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.vietnamese);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Español'),
                value: 'es',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.spanish);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Português'),
                value: 'pt',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.portuguese);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Bahasa Indonesia'),
                value: 'id',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.indonesian);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Русский'),
                value: 'ru',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.russian);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('हिन्दी'),
                value: 'hi',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.hindi);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('العربية'),
                value: 'ar',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.arabic);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Türkçe'),
                value: 'tr',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.turkish);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Italiano'),
                value: 'it',
                groupValue: currentKey,
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(SupportedLocale.italian);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 앱 초기화 (모든 데이터 삭제)
  Future<void> _resetApp(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: l10n.dialogResetAppTitle,
      content: l10n.dialogResetAppContent,
    );

    if (confirm && context.mounted) {
      try {
        // 로딩 표시
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        // 1. 모든 데이터 삭제
        final db = ref.read(databaseServiceProvider);
        await db.clearAllData();

        // 2. 모든 설정을 기본값으로 초기화
        await ref.read(chipLayoutSingleLineProvider.notifier).setChipLayoutSingleLine(true);
        await ref.read(defaultChannelSectionProvider.notifier).setDefaultSection(ChannelSection.home);
        await ref.read(videosPerChannelProvider.notifier).setVideosPerChannel(3);
        await ref.read(channelTapActionProvider.notifier).setChannelTapAction(ChannelTapAction.latestVideos);
        await ref.read(navOrderProvider.notifier).resetToDefault();
        await ref.read(latestVideosLayoutProvider.notifier).reset();
        await ref.read(favoritesLayoutProvider.notifier).reset();
        await ref.read(channelVideosLayoutProvider.notifier).reset();
        await ref.read(playlistVideosLayoutProvider.notifier).reset();
        await ref.read(latestVideosTapActionProvider.notifier).reset();
        await ref.read(favoritesTapActionProvider.notifier).reset();
        await ref.read(channelVideosTapActionProvider.notifier).reset();
        await ref.read(playlistVideosTapActionProvider.notifier).reset();
        // "다음부터 안보기" 플래그 초기화
        await ref.read(hideCreateCollectionDialogProvider.notifier).setHide(false);
        // 플로팅 버튼 보이기 초기화
        await ref.read(showCollectionFabProvider.notifier).setShowCollectionFab(true);
        // 컬렉션 보기 설정 초기화
        await ref.read(showCollectionChannelCountProvider.notifier).setShowChannelCount(true);
        await ref.read(collectionSizeLargeProvider.notifier).setLarge(true);
        // 새영상 화면 컬렉션 보기 설정 초기화
        await ref.read(latestVideosShowVideoCountProvider.notifier).setShowVideoCount(false);
        await ref.read(latestVideosCollectionSizeLargeProvider.notifier).setLarge(true);
        // 새영상 화면 칩 레이아웃 초기화
        await ref.read(latestVideosChipLayoutSingleLineProvider.notifier).setChipLayoutSingleLine(true);
        // 재생목록 영상 정렬 순서 초기화
        await ref.read(playlistVideosSortOrdersProvider.notifier).reset();

        // 3. 프로바이더 상태 새로고침
        await ref.read(channelsProvider.notifier).loadChannels();
        await ref.read(collectionsProvider.notifier).loadCollections();
        await ref.read(favoritesProvider.notifier).loadFavorites();

        // 4. 새영상, 재생목록 상태 초기화
        ref.read(latestVideosProvider.notifier).clear();
        await ref.read(playlistsProvider.notifier).clearWithCache();

        if (context.mounted) {
          Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
          Helpers.showSnackBar(context, l10n.dialogResetAppSuccess);
        }
      } catch (e) {
        if (context.mounted) {
          Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
          Helpers.showSnackBar(
            context,
            l10n.errorGeneric(e.toString()),
            isError: true,
          );
        }
      }
    }
  }

  /// 이미지 캐시 삭제
  Future<void> _clearImageCache(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: l10n.dialogClearCacheTitle,
      content: l10n.dialogClearCacheContent,
    );

    if (confirm && context.mounted) {
      try {
        // 캐시 매니저를 사용하여 캐시 삭제
        final cacheManager = DefaultCacheManager();
        await cacheManager.emptyCache();

        if (context.mounted) {
          Helpers.showSnackBar(context, l10n.dialogClearCacheSuccess);
        }
      } catch (e) {
        if (context.mounted) {
          Helpers.showSnackBar(
            context,
            '${l10n.dialogClearCacheFailed}: ${e.toString()}',
            isError: true,
          );
        }
      }
    }
  }

  /// 백업 실행
  Future<void> _handleBackup(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final db = ref.read(databaseServiceProvider);
      final backupService = BackupService(db);

      // 로딩 표시
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      final filePath = await backupService.exportToFile();

      if (context.mounted) {
        Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
      }

      if (filePath != null && context.mounted) {
        Helpers.showSnackBar(
          context,
          l10n.dialogBackupSuccess(filePath),
        );
      } else if (context.mounted) {
        Helpers.showSnackBar(context, l10n.dialogBackupCancelled);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
        Helpers.showSnackBar(
          context,
          '${l10n.dialogBackupFailed}: ${e.toString()}',
          isError: true,
        );
      }
    }
  }

  /// 복원 실행
  Future<void> _handleRestore(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await Helpers.showConfirmDialog(
      context,
      title: l10n.dialogRestoreTitle,
      content: l10n.dialogRestoreContent,
    );

    if (!confirm || !context.mounted) return;

    try {
      final db = ref.read(databaseServiceProvider);
      final backupService = BackupService(db);

      // 로딩 표시
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      await backupService.importFromFile();

      if (context.mounted) {
        Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
      }

      // 데이터 새로고침
      await ref.read(channelsProvider.notifier).loadChannels();
      await ref.read(collectionsProvider.notifier).loadCollections();
      await ref.read(favoritesProvider.notifier).loadFavorites();
      // 재생목록 새로고침 (순서 복원을 위해)
      await ref.read(playlistsProvider.notifier).clearWithCache();
      await ref.read(playlistsProvider.notifier).fetchPlaylists();

      // 컬렉션 보기 설정 새로고침 (SharedPreferences에서 다시 읽기)
      final prefs = await SharedPreferences.getInstance();
      final showChannelCount = prefs.getBool(Constants.keyShowCollectionChannelCount) ?? true;
      final sizeLarge = prefs.getBool(Constants.keyCollectionSizeLarge) ?? true;
      await ref.read(showCollectionChannelCountProvider.notifier).setShowChannelCount(showChannelCount);
      await ref.read(collectionSizeLargeProvider.notifier).setLarge(sizeLarge);
      // 새영상 화면 컬렉션 보기 설정 새로고침
      final latestShowVideoCount = prefs.getBool(Constants.keyLatestVideosShowVideoCount) ?? false;
      final latestSizeLarge = prefs.getBool(Constants.keyLatestVideosCollectionSizeLarge) ?? true;
      await ref.read(latestVideosShowVideoCountProvider.notifier).setShowVideoCount(latestShowVideoCount);
      await ref.read(latestVideosCollectionSizeLargeProvider.notifier).setLarge(latestSizeLarge);
      // 칩 레이아웃 설정 새로고침
      final chipSingleLine = prefs.getBool(Constants.keyChipLayoutSingleLine) ?? true;
      final latestChipSingleLine = prefs.getBool(Constants.keyLatestVideosChipLayoutSingleLine) ?? true;
      await ref.read(chipLayoutSingleLineProvider.notifier).setChipLayoutSingleLine(chipSingleLine);
      await ref.read(latestVideosChipLayoutSingleLineProvider.notifier).setChipLayoutSingleLine(latestChipSingleLine);
      // 재생목록 영상 정렬 순서 새로고침
      final playlistSortOrdersJson = prefs.getString(Constants.keyPlaylistVideosSortOrders);
      if (playlistSortOrdersJson != null) {
        final Map<String, dynamic> jsonMap = Map<String, dynamic>.from(
          Map.castFrom(jsonDecode(playlistSortOrdersJson))
        );
        final orders = <String, PlaylistVideosSortOrder>{};
        for (final entry in jsonMap.entries) {
          orders[entry.key] = PlaylistVideosSortOrderExtension.fromString(entry.value as String?);
        }
        await ref.read(playlistVideosSortOrdersProvider.notifier).setAllSortOrders(orders);
      }

      if (context.mounted) {
        Helpers.showSnackBar(context, l10n.dialogRestoreSuccess);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
        Helpers.showSnackBar(
          context,
          '${l10n.dialogRestoreFailed}: ${e.toString()}',
          isError: true,
        );
      }
    }
  }

  Widget _buildSettingCard({
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Icon(
        icon,
        color: iconColor ?? Colors.grey,
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            )
          : null,
      trailing: onTap != null
          ? Icon(Icons.chevron_right, color: Colors.grey[400])
          : null,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/icon/app_icon.png',
                width: 28,
                height: 28,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                AppLocalizations.of(context)!.navSettings,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          // 오른쪽 스와이프로 화면 닫기 (velocity threshold: 300)
          if (details.primaryVelocity != null && details.primaryVelocity! > 300) {
            Navigator.of(context).pop();
          }
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
          const SizedBox(height: 16),
          // 일반 설정 그룹
          _buildSettingCard(
            children: [
              _buildSettingTile(
                icon: Icons.language,
                title: l10n.settingsLanguage,
                subtitle: () {
                  final locale = ref.watch(localeProvider);
                  if (locale == null) return l10n.settingsLanguageSystem;
                  final code = locale.countryCode == 'TW' ? 'zh_TW' : locale.languageCode;
                  return SupportedLocale.fromCode(code).displayName;
                }(),
                onTap: () => _showLanguageDialog(context, ref),
                iconColor: Colors.grey,
              ),
              _buildSettingTile(
                icon: Icons.reorder,
                title: l10n.settingsMenuOrder,
                subtitle: l10n.settingsMenuOrderDesc,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NavOrderScreen(),
                    ),
                  );
                },
                iconColor: Colors.grey,
              ),
            ],
          ),
          // 데이터 관리 그룹
          _buildSettingCard(
            children: [
              _buildSettingTile(
                icon: Icons.backup,
                title: l10n.settingsBackup,
                onTap: () => _handleBackup(context, ref),
                iconColor: Colors.grey,
              ),
              _buildSettingTile(
                icon: Icons.restore,
                title: l10n.settingsRestore,
                onTap: () => _handleRestore(context, ref),
                iconColor: Colors.grey,
              ),
              _buildSettingTile(
                icon: Icons.delete_sweep,
                title: l10n.settingsClearCache,
                onTap: () => _clearImageCache(context),
                iconColor: Colors.grey,
              ),
            ],
          ),
          // 계정 그룹
          _buildSettingCard(
            children: [
              _buildSettingTile(
                icon: Icons.account_circle,
                title: l10n.settingsGoogleAccount,
                subtitle: authState.userEmail ?? l10n.settingsNotLoggedIn,
                iconColor: Colors.grey,
              ),
              _buildSettingTile(
                icon: Icons.logout,
                title: l10n.settingsLogout,
                onTap: () => _handleLogout(context, ref),
                iconColor: Colors.grey,
              ),
            ],
          ),
          // 앱 정보 그룹
          _buildSettingCard(
            children: [
              _buildSettingTile(
                icon: Icons.refresh,
                title: l10n.settingsResetApp,
                onTap: () => _resetApp(context, ref),
                iconColor: Colors.grey,
              ),
              _buildSettingTile(
                icon: Icons.info_outline,
                title: l10n.settingsVersion,
                subtitle: AppConfig.appVersion,
                onTap: () {
                  showLicensePage(
                    context: context,
                    applicationName: AppConfig.appName,
                    applicationVersion: AppConfig.appVersion,
                  );
                },
                iconColor: Colors.grey,
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}
