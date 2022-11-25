// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mata_pelajaran.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MataPelajaran _$MataPelajaranFromJson(Map<String, dynamic> json) =>
    MataPelajaran(
      json['id'] as int,
      json['name'] as String,
      divisi: Divisi.fromJson(json['divisi_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MataPelajaranToJson(MataPelajaran instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'divisi_detail': instance.divisi,
    };
