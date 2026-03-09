import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

/// 테마 모드 상태 Provider
final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

/// 테마 모드 관리 Notifier
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.dark) {
    _loadThemeMode();
  }

  /// 저장된 테마 모드 불러오기
  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeString =
          prefs.getString(Constants.keyThemeMode) ?? 'dark';

      state = _themeModeFromString(themeModeString);
    } catch (e) {
      state = ThemeMode.dark;
    }
  }

  /// 테마 모드 변경
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyThemeMode, _themeModeToString(mode));
    } catch (e) {
      // 저장 실패는 무시 (앱 재시작 시 다시 system으로 돌아감)
    }
  }

  /// 테마 모드 토글 (Light ↔ Dark)
  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(newMode);
  }

  /// String → ThemeMode 변환
  ThemeMode _themeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// ThemeMode → String 변환
  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }

  /// 테마 모드 표시 문자열
  String getThemeModeDisplayString() {
    switch (state) {
      case ThemeMode.light:
        return '라이트 모드';
      case ThemeMode.dark:
        return '다크 모드';
      default:
        return '시스템 설정 따르기';
    }
  }
}
