// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NPB _$NPBFromJson(Map<String, dynamic> json) => NPB(
      json['no'] as int,
      const MataPelajaranConverter()
          .fromJson(json['mapel'] as Map<String, dynamic>),
      json['presensi'] as String,
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$NPBToJson(NPB instance) => <String, dynamic>{
      'no': instance.no,
      'mapel': const MataPelajaranConverter().toJson(instance.pelajaran),
      'presensi': instance.presensi,
      'note': instance.note,
    };
