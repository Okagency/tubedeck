// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectionImpl _$$CollectionImplFromJson(Map<String, dynamic> json) =>
    _$CollectionImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      colorCode: (json['colorCode'] as num).toInt(),
      displayOrder: (json['displayOrder'] as num).toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CollectionImplToJson(_$CollectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'colorCode': instance.colorCode,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
