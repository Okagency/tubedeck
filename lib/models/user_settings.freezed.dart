// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) {
  return _UserSettings.fromJson(json);
}

/// @nodoc
mixin _$UserSettings {
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  AutoRefreshInterval get autoRefreshInterval =>
      throw _privateConstructorUsedError;
  DateTime? get lastSyncTime => throw _privateConstructorUsedError;

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
    UserSettings value,
    $Res Function(UserSettings) then,
  ) = _$UserSettingsCopyWithImpl<$Res, UserSettings>;
  @useResult
  $Res call({
    ThemeMode themeMode,
    AutoRefreshInterval autoRefreshInterval,
    DateTime? lastSyncTime,
  });
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res, $Val extends UserSettings>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? autoRefreshInterval = null,
    Object? lastSyncTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            themeMode: null == themeMode
                ? _value.themeMode
                : themeMode // ignore: cast_nullable_to_non_nullable
                      as ThemeMode,
            autoRefreshInterval: null == autoRefreshInterval
                ? _value.autoRefreshInterval
                : autoRefreshInterval // ignore: cast_nullable_to_non_nullable
                      as AutoRefreshInterval,
            lastSyncTime: freezed == lastSyncTime
                ? _value.lastSyncTime
                : lastSyncTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSettingsImplCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$$UserSettingsImplCopyWith(
    _$UserSettingsImpl value,
    $Res Function(_$UserSettingsImpl) then,
  ) = __$$UserSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ThemeMode themeMode,
    AutoRefreshInterval autoRefreshInterval,
    DateTime? lastSyncTime,
  });
}

/// @nodoc
class __$$UserSettingsImplCopyWithImpl<$Res>
    extends _$UserSettingsCopyWithImpl<$Res, _$UserSettingsImpl>
    implements _$$UserSettingsImplCopyWith<$Res> {
  __$$UserSettingsImplCopyWithImpl(
    _$UserSettingsImpl _value,
    $Res Function(_$UserSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? autoRefreshInterval = null,
    Object? lastSyncTime = freezed,
  }) {
    return _then(
      _$UserSettingsImpl(
        themeMode: null == themeMode
            ? _value.themeMode
            : themeMode // ignore: cast_nullable_to_non_nullable
                  as ThemeMode,
        autoRefreshInterval: null == autoRefreshInterval
            ? _value.autoRefreshInterval
            : autoRefreshInterval // ignore: cast_nullable_to_non_nullable
                  as AutoRefreshInterval,
        lastSyncTime: freezed == lastSyncTime
            ? _value.lastSyncTime
            : lastSyncTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSettingsImpl implements _UserSettings {
  const _$UserSettingsImpl({
    this.themeMode = ThemeMode.system,
    this.autoRefreshInterval = AutoRefreshInterval.threeHours,
    this.lastSyncTime,
  });

  factory _$UserSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSettingsImplFromJson(json);

  @override
  @JsonKey()
  final ThemeMode themeMode;
  @override
  @JsonKey()
  final AutoRefreshInterval autoRefreshInterval;
  @override
  final DateTime? lastSyncTime;

  @override
  String toString() {
    return 'UserSettings(themeMode: $themeMode, autoRefreshInterval: $autoRefreshInterval, lastSyncTime: $lastSyncTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.autoRefreshInterval, autoRefreshInterval) ||
                other.autoRefreshInterval == autoRefreshInterval) &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, themeMode, autoRefreshInterval, lastSyncTime);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      __$$UserSettingsImplCopyWithImpl<_$UserSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSettingsImplToJson(this);
  }
}

abstract class _UserSettings implements UserSettings {
  const factory _UserSettings({
    final ThemeMode themeMode,
    final AutoRefreshInterval autoRefreshInterval,
    final DateTime? lastSyncTime,
  }) = _$UserSettingsImpl;

  factory _UserSettings.fromJson(Map<String, dynamic> json) =
      _$UserSettingsImpl.fromJson;

  @override
  ThemeMode get themeMode;
  @override
  AutoRefreshInterval get autoRefreshInterval;
  @override
  DateTime? get lastSyncTime;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
