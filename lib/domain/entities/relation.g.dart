// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Relation _$RelationFromJson(Map<String, dynamic> json) => Relation(
      json['id'] as int,
      const _TeacherConverter()
          .fromJson(json['teacher'] as Map<String, dynamic>),
      Santri.fromJson(json['student'] as Map<String, dynamic>),
      name: json['name'] as String?,
      isActive: json['is_active'] as bool? ?? false,
    );

Map<String, dynamic> _$RelationToJson(Relation instance) => <String, dynamic>{
      'id': instance.id,
      'teacher': const _TeacherConverter().toJson(instance.teacher),
      'student': instance.santri,
      'name': instance.name,
      'is_active': instance.isActive,
    };
