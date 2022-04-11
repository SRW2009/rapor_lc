// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npbmo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NPBMO _$NPBMOFromJson(Map<String, dynamic> json) => NPBMO(
      json['no'] as int,
      const MataPelajaranConverter()
          .fromJson(json['mapel'] as Map<String, dynamic>),
      json['presensi'] as String,
      json['n'] as int,
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$NPBMOToJson(NPBMO instance) => <String, dynamic>{
      'no': instance.no,
      'mapel': const MataPelajaranConverter().toJson(instance.pelajaran),
      'presensi': instance.presensi,
      'note': instance.note,
      'n': instance.n,
    };
