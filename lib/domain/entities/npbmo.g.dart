// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npbmo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NPBMO _$NPBMOFromJson(Map<String, dynamic> json) => NPBMO(
      json['id'] as int,
      const SantriConverter().fromJson(json['santri'] as Map<String, dynamic>),
      json['semester'] as int,
      json['tahun_ajaran'] as String,
      const MataPelajaranConverter()
          .fromJson(json['pelajaran'] as Map<String, dynamic>),
      json['n'] as int,
      json['presensi'] as String,
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$NPBMOToJson(NPBMO instance) => <String, dynamic>{
      'n': instance.n,
      'id': instance.id,
      'presensi': instance.presensi,
      'santri': const SantriConverter().toJson(instance.santri),
      'semester': instance.semester,
      'pelajaran': const MataPelajaranConverter().toJson(instance.pelajaran),
      'tahun_ajaran': instance.tahun_ajaran,
      'note': instance.note,
    };
