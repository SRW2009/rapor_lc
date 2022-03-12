// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mata_pelajaran.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MataPelajaran _$MataPelajaranFromJson(Map<String, dynamic> json) =>
    MataPelajaran(
      json['id'] as int,
      const DivisiConverter().fromJson(json['divisi'] as Map<String, dynamic>),
      json['nama_mapel'] as String,
    );

Map<String, dynamic> _$MataPelajaranToJson(MataPelajaran instance) =>
    <String, dynamic>{
      'id': instance.id,
      'divisi': const DivisiConverter().toJson(instance.divisi),
      'nama_mapel': instance.nama_mapel,
    };
