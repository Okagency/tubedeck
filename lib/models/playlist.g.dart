// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaylistImpl _$$PlaylistImplFromJson(Map<String, dynamic> json) =>
    _$PlaylistImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      itemCount: (json['itemCount'] as num).toInt(),
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
    );

Map<String, dynamic> _$$PlaylistImplToJson(_$PlaylistImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
      'itemCount': instance.itemCount,
      'publishedAt': instance.publishedAt?.toIso8601String(),
    };
