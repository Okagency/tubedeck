import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

enum ThemeMode {
  light,
  dark,
  system,
}

enum AutoRefreshInterval {
  manual,
  oneHour,
  threeHours,
  sixHours,
}

@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(AutoRefreshInterval.threeHours)
    AutoRefreshInterval autoRefreshInterval,
    DateTime? lastSyncTime,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}

extension AutoRefreshIntervalExtension on AutoRefreshInterval {
  Duration? get duration {
    switch (this) {
      case AutoRefreshInterval.manual:
        return null;
      case AutoRefreshInterval.oneHour:
        return const Duration(hours: 1);
      case AutoRefreshInterval.threeHours:
        return const Duration(hours: 3);
      case AutoRefreshInterval.sixHours:
        return const Duration(hours: 6);
    }
  }

  String get displayName {
    switch (this) {
      case AutoRefreshInterval.manual:
        return '수동';
      case AutoRefreshInterval.oneHour:
        return '1시간마다';
      case AutoRefreshInterval.threeHours:
        return '3시간마다';
      case AutoRefreshInterval.sixHours:
        return '6시간마다';
    }
  }
}
