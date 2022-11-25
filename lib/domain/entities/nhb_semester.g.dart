// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nhb_semester.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NHBSemester _$NHBSemesterFromJson(Map<String, dynamic> json) => NHBSemester(
      json['no'] as int,
      MataPelajaran.fromJson(json['mapel'] as Map<String, dynamic>),
      json['nilai_harian'] as int,
      json['nilai_bulanan'] as int,
      json['nilai_projek'] as int,
      json['nilai_akhir'] as int,
      json['akumulasi'] as int,
      json['predikat'] as String,
    );

Map<String, dynamic> _$NHBSemesterToJson(NHBSemester instance) =>
    <String, dynamic>{
      'no': instance.no,
      'mapel': instance.pelajaran,
      'nilai_harian': instance.nilai_harian,
      'nilai_bulanan': instance.nilai_bulanan,
      'nilai_projek': instance.nilai_projek,
      'nilai_akhir': instance.nilai_akhir,
      'akumulasi': instance.akumulasi,
      'predikat': instance.predikat,
    };
