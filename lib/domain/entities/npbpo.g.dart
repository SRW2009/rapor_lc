// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npbpo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NPBPO _$NPBPOFromJson(Map<String, dynamic> json) => NPBPO(
      json['id'] as int,
      const SantriConverter().fromJson(json['santri'] as Map<String, dynamic>),
      json['semester'] as int,
      json['tahun_ajaran'] as String,
      const MataPelajaranConverter()
          .fromJson(json['pelajaran'] as Map<String, dynamic>),
      json['presensi'] as String,
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$NPBPOToJson(NPBPO instance) => <String, dynamic>{
      'id': instance.id,
      'pelajaran': const MataPelajaranConverter().toJson(instance.pelajaran),
      'presensi': instance.presensi,
      'santri': const SantriConverter().toJson(instance.santri),
      'semester': instance.semester,
      'tahun_ajaran': instance.tahun_ajaran,
      'note': instance.note,
    };
