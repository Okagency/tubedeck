import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'collection.freezed.dart';
part 'collection.g.dart';

@freezed
class Collection with _$Collection {
  const factory Collection({
    required String id,
    required String name,
    required int colorCode,
    required int displayOrder,
    DateTime? createdAt,
  }) = _Collection;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  factory Collection.fromDatabase(Map<String, dynamic> map) {
    return Collection(
      id: map['id'] as String,
      name: map['name'] as String,
      colorCode: map['color_code'] as int,
      displayOrder: map['display_order'] as int,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
    );
  }

  static Map<String, dynamic> toDatabase(Collection collection) {
    return {
      'id': collection.id,
      'name': collection.name,
      'color_code': collection.colorCode,
      'display_order': collection.displayOrder,
      'created_at': collection.createdAt?.toIso8601String(),
    };
  }
}

extension CollectionExtension on Collection {
  Color get color => Color(colorCode);
}
