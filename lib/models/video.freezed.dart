// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Video _$VideoFromJson(Map<String, dynamic> json) {
  return _Video.fromJson(json);
}

/// @nodoc
mixin _$Video {
  String get id => throw _privateConstructorUsedError;
  String get channelId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get channelTitle => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  DateTime get publishedAt => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  int? get viewCount => throw _privateConstructorUsedError;
  int? get likeCount => throw _privateConstructorUsedError;

  /// Serializes this Video to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoCopyWith<Video> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoCopyWith<$Res> {
  factory $VideoCopyWith(Video value, $Res Function(Video) then) =
      _$VideoCopyWithImpl<$Res, Video>;
  @useResult
  $Res call({
    String id,
    String channelId,
    String title,
    String channelTitle,
    String? description,
    String? thumbnailUrl,
    DateTime publishedAt,
    String? duration,
    int? viewCount,
    int? likeCount,
  });
}

/// @nodoc
class _$VideoCopyWithImpl<$Res, $Val extends Video>
    implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channelId = null,
    Object? title = null,
    Object? channelTitle = null,
    Object? description = freezed,
    Object? thumbnailUrl = freezed,
    Object? publishedAt = null,
    Object? duration = freezed,
    Object? viewCount = freezed,
    Object? likeCount = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            channelId: null == channelId
                ? _value.channelId
                : channelId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            channelTitle: null == channelTitle
                ? _value.channelTitle
                : channelTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            publishedAt: null == publishedAt
                ? _value.publishedAt
                : publishedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String?,
            viewCount: freezed == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            likeCount: freezed == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VideoImplCopyWith<$Res> implements $VideoCopyWith<$Res> {
  factory _$$VideoImplCopyWith(
    _$VideoImpl value,
    $Res Function(_$VideoImpl) then,
  ) = __$$VideoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String channelId,
    String title,
    String channelTitle,
    String? description,
    String? thumbnailUrl,
    DateTime publishedAt,
    String? duration,
    int? viewCount,
    int? likeCount,
  });
}

/// @nodoc
class __$$VideoImplCopyWithImpl<$Res>
    extends _$VideoCopyWithImpl<$Res, _$VideoImpl>
    implements _$$VideoImplCopyWith<$Res> {
  __$$VideoImplCopyWithImpl(
    _$VideoImpl _value,
    $Res Function(_$VideoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channelId = null,
    Object? title = null,
    Object? channelTitle = null,
    Object? description = freezed,
    Object? thumbnailUrl = freezed,
    Object? publishedAt = null,
    Object? duration = freezed,
    Object? viewCount = freezed,
    Object? likeCount = freezed,
  }) {
    return _then(
      _$VideoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        channelId: null == channelId
            ? _value.channelId
            : channelId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        channelTitle: null == channelTitle
            ? _value.channelTitle
            : channelTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        thumbnailUrl: freezed == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        publishedAt: null == publishedAt
            ? _value.publishedAt
            : publishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String?,
        viewCount: freezed == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        likeCount: freezed == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoImpl implements _Video {
  const _$VideoImpl({
    required this.id,
    required this.channelId,
    required this.title,
    required this.channelTitle,
    this.description,
    this.thumbnailUrl,
    required this.publishedAt,
    this.duration,
    this.viewCount,
    this.likeCount,
  });

  factory _$VideoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoImplFromJson(json);

  @override
  final String id;
  @override
  final String channelId;
  @override
  final String title;
  @override
  final String channelTitle;
  @override
  final String? description;
  @override
  final String? thumbnailUrl;
  @override
  final DateTime publishedAt;
  @override
  final String? duration;
  @override
  final int? viewCount;
  @override
  final int? likeCount;

  @override
  String toString() {
    return 'Video(id: $id, channelId: $channelId, title: $title, channelTitle: $channelTitle, description: $description, thumbnailUrl: $thumbnailUrl, publishedAt: $publishedAt, duration: $duration, viewCount: $viewCount, likeCount: $likeCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.channelTitle, channelTitle) ||
                other.channelTitle == channelTitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    channelId,
    title,
    channelTitle,
    description,
    thumbnailUrl,
    publishedAt,
    duration,
    viewCount,
    likeCount,
  );

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoImplCopyWith<_$VideoImpl> get copyWith =>
      __$$VideoImplCopyWithImpl<_$VideoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoImplToJson(this);
  }
}

abstract class _Video implements Video {
  const factory _Video({
    required final String id,
    required final String channelId,
    required final String title,
    required final String channelTitle,
    final String? description,
    final String? thumbnailUrl,
    required final DateTime publishedAt,
    final String? duration,
    final int? viewCount,
    final int? likeCount,
  }) = _$VideoImpl;

  factory _Video.fromJson(Map<String, dynamic> json) = _$VideoImpl.fromJson;

  @override
  String get id;
  @override
  String get channelId;
  @override
  String get title;
  @override
  String get channelTitle;
  @override
  String? get description;
  @override
  String? get thumbnailUrl;
  @override
  DateTime get publishedAt;
  @override
  String? get duration;
  @override
  int? get viewCount;
  @override
  int? get likeCount;

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoImplCopyWith<_$VideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
