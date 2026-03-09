// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoImpl _$$VideoImplFromJson(Map<String, dynamic> json) => _$VideoImpl(
  id: json['id'] as String,
  channelId: json['channelId'] as String,
  title: json['title'] as String,
  channelTitle: json['channelTitle'] as String,
  description: json['description'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  publishedAt: DateTime.parse(json['publishedAt'] as String),
  duration: json['duration'] as String?,
  viewCount: (json['viewCount'] as num?)?.toInt(),
  likeCount: (json['likeCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$$VideoImplToJson(_$VideoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channelId': instance.channelId,
      'title': instance.title,
      'channelTitle': instance.channelTitle,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'duration': instance.duration,
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
    };
