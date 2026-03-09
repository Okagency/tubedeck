// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSettingsImpl _$$UserSettingsImplFromJson(Map<String, dynamic> json) =>
    _$UserSettingsImpl(
      themeMode:
          $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      autoRefreshInterval:
          $enumDecodeNullable(
            _$AutoRefreshIntervalEnumMap,
            json['autoRefreshInterval'],
          ) ??
          AutoRefreshInterval.threeHours,
      lastSyncTime: json['lastSyncTime'] == null
          ? null
          : DateTime.parse(json['lastSyncTime'] as String),
    );

Map<String, dynamic> _$$UserSettingsImplToJson(_$UserSettingsImpl instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'autoRefreshInterval':
          _$AutoRefreshIntervalEnumMap[instance.autoRefreshInterval]!,
      'lastSyncTime': instance.lastSyncTime?.toIso8601String(),
    };

const _$ThemeModeEnumMap = {
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
  ThemeMode.system: 'system',
};

const _$AutoRefreshIntervalEnumMap = {
  AutoRefreshInterval.manual: 'manual',
  AutoRefreshInterval.oneHour: 'oneHour',
  AutoRefreshInterval.threeHours: 'threeHours',
  AutoRefreshInterval.sixHours: 'sixHours',
};
