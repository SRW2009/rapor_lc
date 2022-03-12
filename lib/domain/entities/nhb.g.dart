// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nhb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NHB _$NHBFromJson(Map<String, dynamic> json) => NHB(
      json['id'] as int,
      const SantriConverter().fromJson(json['santri'] as Map<String, dynamic>),
      json['semester'] as int,
      json['tahun_ajaran'] as String,
      const MataPelajaranConverter()
          .fromJson(json['pelajaran'] as Map<String, dynamic>),
      json['nilai_harian'] as int,
      json['nilai_bulanan'] as int,
      json['nilai_project'] as int,
      json['nilai_akhir'] as int,
      json['akumulasi'] as int,
      json['predikat'] as String,
    );

Map<String, dynamic> _$NHBToJson(NHB instance) => <String, dynamic>{
      'id': instance.id,
      'santri': const SantriConverter().toJson(instance.santri),
      'semester': instance.semester,
      'tahun_ajaran': instance.tahun_ajaran,
      'pelajaran': const MataPelajaranConverter().toJson(instance.pelajaran),
      'nilai_harian': instance.nilai_harian,
      'nilai_bulanan': instance.nilai_bulanan,
      'nilai_project': instance.nilai_project,
      'nilai_akhir': instance.nilai_akhir,
      'akumulasi': instance.akumulasi,
      'predikat': instance.predikat,
    };
