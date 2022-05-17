// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mata_pelajaran.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MataPelajaran _$MataPelajaranFromJson(Map<String, dynamic> json) =>
    MataPelajaran(
      json['id'] as int,
      json['name'] as String,
      divisi: const NullableDivisiConverter()
          .fromJson(json['divisi'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$MataPelajaranToJson(MataPelajaran instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'divisi': const NullableDivisiConverter().toJson(instance.divisi),
    };
