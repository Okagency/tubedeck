import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 지원하는 언어 목록
enum SupportedLocale {
  english('en', 'English'),
  korean('ko', '한국어'),
  japanese('ja', '日本語'),
  simplifiedChinese('zh', '简体中文'),
  traditionalChinese('zh_TW', '繁體中文'),
  german('de', 'Deutsch'),
  thai('th', 'ไทย'),
  vietnamese('vi', 'Tiếng Việt'),
  french('fr', 'Français'),
  spanish('es', 'Español'),
  portuguese('pt', 'Português'),
  indonesian('id', 'Bahasa Indonesia'),
  russian('ru', 'Русский'),
  hindi('hi', 'हिन्दी'),
  arabic('ar', 'العربية'),
  turkish('tr', 'Türkçe'),
  italian('it', 'Italiano');

  final String code;
  final String displayName;

  const SupportedLocale(this.code, this.displayName);

  Locale get locale {
    if (code.contains('_')) {
      final parts = code.split('_');
      return Locale(parts[0], parts[1]);
    }
    return Locale(code);
  }

  static SupportedLocale fromCode(String code) {
    return SupportedLocale.values.firstWhere(
      (locale) => locale.code == code,
      orElse: () => SupportedLocale.english,
    );
  }
}

/// 현재 선택된 언어를 관리하는 Provider
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale?> {
  static const String _localeKey = 'selected_locale';

  LocaleNotifier() : super(null) {
    _loadLocale();
  }

  /// 저장된 언어 불러오기
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString(_localeKey);

    if (localeCode != null) {
      state = Locale(localeCode);
    }
    // state가 null이면 시스템 언어를 자동으로 따름
  }

  /// 언어 변경 및 저장
  Future<void> setLocale(SupportedLocale supportedLocale) async {
    state = supportedLocale.locale;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, supportedLocale.code);
  }

  /// 시스템 언어로 변경 (자동)
  Future<void> setSystemLocale() async {
    state = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_localeKey);
  }
}
