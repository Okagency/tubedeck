// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChannelImpl _$$ChannelImplFromJson(Map<String, dynamic> json) =>
    _$ChannelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      subscriberCount: (json['subscriberCount'] as num?)?.toInt(),
      lastUploadDate: json['lastUploadDate'] == null
          ? null
          : DateTime.parse(json['lastUploadDate'] as String),
      uploadsPlaylistId: json['uploadsPlaylistId'] as String?,
      sortOrder: (json['sortOrder'] as num).toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      isSubscribed: json['isSubscribed'] as bool? ?? true,
      defaultSection: json['defaultSection'] as String?,
    );

Map<String, dynamic> _$$ChannelImplToJson(_$ChannelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumbnailUrl': instance.thumbnailUrl,
      'subscriberCount': instance.subscriberCount,
      'lastUploadDate': instance.lastUploadDate?.toIso8601String(),
      'uploadsPlaylistId': instance.uploadsPlaylistId,
      'sortOrder': instance.sortOrder,
      'createdAt': instance.createdAt?.toIso8601String(),
      'isSubscribed': instance.isSubscribed,
      'defaultSection': instance.defaultSection,
    };
