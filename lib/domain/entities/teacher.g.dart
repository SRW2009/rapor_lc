// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      json['id'] as int,
      json['name'] as String,
      email: json['email'] as String?,
      password: json['password'] as String?,
      isLeader: json['is_leader'] as bool?,
      divisi: const NullableDivisiConverter()
          .fromJson(json['divisi'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'id': instance.id,
      'is_leader': instance.isLeader,
      'divisi': const NullableDivisiConverter().toJson(instance.divisi),
    };
