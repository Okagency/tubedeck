// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'channel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Channel _$ChannelFromJson(Map<String, dynamic> json) {
  return _Channel.fromJson(json);
}

/// @nodoc
mixin _$Channel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  int? get subscriberCount => throw _privateConstructorUsedError;
  DateTime? get lastUploadDate => throw _privateConstructorUsedError;
  String? get uploadsPlaylistId => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  bool get isSubscribed => throw _privateConstructorUsedError;
  String? get defaultSection => throw _privateConstructorUsedError;

  /// Serializes this Channel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChannelCopyWith<Channel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelCopyWith<$Res> {
  factory $ChannelCopyWith(Channel value, $Res Function(Channel) then) =
      _$ChannelCopyWithImpl<$Res, Channel>;
  @useResult
  $Res call({
    String id,
    String title,
    String? thumbnailUrl,
    int? subscriberCount,
    DateTime? lastUploadDate,
    String? uploadsPlaylistId,
    int sortOrder,
    DateTime? createdAt,
    bool isSubscribed,
    String? defaultSection,
  });
}

/// @nodoc
class _$ChannelCopyWithImpl<$Res, $Val extends Channel>
    implements $ChannelCopyWith<$Res> {
  _$ChannelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? thumbnailUrl = freezed,
    Object? subscriberCount = freezed,
    Object? lastUploadDate = freezed,
    Object? uploadsPlaylistId = freezed,
    Object? sortOrder = null,
    Object? createdAt = freezed,
    Object? isSubscribed = null,
    Object? defaultSection = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            subscriberCount: freezed == subscriberCount
                ? _value.subscriberCount
                : subscriberCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            lastUploadDate: freezed == lastUploadDate
                ? _value.lastUploadDate
                : lastUploadDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            uploadsPlaylistId: freezed == uploadsPlaylistId
                ? _value.uploadsPlaylistId
                : uploadsPlaylistId // ignore: cast_nullable_to_non_nullable
                      as String?,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isSubscribed: null == isSubscribed
                ? _value.isSubscribed
                : isSubscribed // ignore: cast_nullable_to_non_nullable
                      as bool,
            defaultSection: freezed == defaultSection
                ? _value.defaultSection
                : defaultSection // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChannelImplCopyWith<$Res> implements $ChannelCopyWith<$Res> {
  factory _$$ChannelImplCopyWith(
    _$ChannelImpl value,
    $Res Function(_$ChannelImpl) then,
  ) = __$$ChannelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? thumbnailUrl,
    int? subscriberCount,
    DateTime? lastUploadDate,
    String? uploadsPlaylistId,
    int sortOrder,
    DateTime? createdAt,
    bool isSubscribed,
    String? defaultSection,
  });
}

/// @nodoc
class __$$ChannelImplCopyWithImpl<$Res>
    extends _$ChannelCopyWithImpl<$Res, _$ChannelImpl>
    implements _$$ChannelImplCopyWith<$Res> {
  __$$ChannelImplCopyWithImpl(
    _$ChannelImpl _value,
    $Res Function(_$ChannelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? thumbnailUrl = freezed,
    Object? subscriberCount = freezed,
    Object? lastUploadDate = freezed,
    Object? uploadsPlaylistId = freezed,
    Object? sortOrder = null,
    Object? createdAt = freezed,
    Object? isSubscribed = null,
    Object? defaultSection = freezed,
  }) {
    return _then(
      _$ChannelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailUrl: freezed == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        subscriberCount: freezed == subscriberCount
            ? _value.subscriberCount
            : subscriberCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        lastUploadDate: freezed == lastUploadDate
            ? _value.lastUploadDate
            : lastUploadDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        uploadsPlaylistId: freezed == uploadsPlaylistId
            ? _value.uploadsPlaylistId
            : uploadsPlaylistId // ignore: cast_nullable_to_non_nullable
                  as String?,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isSubscribed: null == isSubscribed
            ? _value.isSubscribed
            : isSubscribed // ignore: cast_nullable_to_non_nullable
                  as bool,
        defaultSection: freezed == defaultSection
            ? _value.defaultSection
            : defaultSection // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChannelImpl implements _Channel {
  const _$ChannelImpl({
    required this.id,
    required this.title,
    this.thumbnailUrl,
    this.subscriberCount,
    this.lastUploadDate,
    this.uploadsPlaylistId,
    required this.sortOrder,
    this.createdAt,
    this.isSubscribed = true,
    this.defaultSection,
  });

  factory _$ChannelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChannelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? thumbnailUrl;
  @override
  final int? subscriberCount;
  @override
  final DateTime? lastUploadDate;
  @override
  final String? uploadsPlaylistId;
  @override
  final int sortOrder;
  @override
  final DateTime? createdAt;
  @override
  @JsonKey()
  final bool isSubscribed;
  @override
  final String? defaultSection;

  @override
  String toString() {
    return 'Channel(id: $id, title: $title, thumbnailUrl: $thumbnailUrl, subscriberCount: $subscriberCount, lastUploadDate: $lastUploadDate, uploadsPlaylistId: $uploadsPlaylistId, sortOrder: $sortOrder, createdAt: $createdAt, isSubscribed: $isSubscribed, defaultSection: $defaultSection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChannelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.subscriberCount, subscriberCount) ||
                other.subscriberCount == subscriberCount) &&
            (identical(other.lastUploadDate, lastUploadDate) ||
                other.lastUploadDate == lastUploadDate) &&
            (identical(other.uploadsPlaylistId, uploadsPlaylistId) ||
                other.uploadsPlaylistId == uploadsPlaylistId) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isSubscribed, isSubscribed) ||
                other.isSubscribed == isSubscribed) &&
            (identical(other.defaultSection, defaultSection) ||
                other.defaultSection == defaultSection));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    thumbnailUrl,
    subscriberCount,
    lastUploadDate,
    uploadsPlaylistId,
    sortOrder,
    createdAt,
    isSubscribed,
    defaultSection,
  );

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChannelImplCopyWith<_$ChannelImpl> get copyWith =>
      __$$ChannelImplCopyWithImpl<_$ChannelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChannelImplToJson(this);
  }
}

abstract class _Channel implements Channel {
  const factory _Channel({
    required final String id,
    required final String title,
    final String? thumbnailUrl,
    final int? subscriberCount,
    final DateTime? lastUploadDate,
    final String? uploadsPlaylistId,
    required final int sortOrder,
    final DateTime? createdAt,
    final bool isSubscribed,
    final String? defaultSection,
  }) = _$ChannelImpl;

  factory _Channel.fromJson(Map<String, dynamic> json) = _$ChannelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get thumbnailUrl;
  @override
  int? get subscriberCount;
  @override
  DateTime? get lastUploadDate;
  @override
  String? get uploadsPlaylistId;
  @override
  int get sortOrder;
  @override
  DateTime? get createdAt;
  @override
  bool get isSubscribed;
  @override
  String? get defaultSection;

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChannelImplCopyWith<_$ChannelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
