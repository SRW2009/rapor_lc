// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NK _$NKFromJson(Map<String, dynamic> json) => NK(
      json['id'] as int,
      const SantriConverter().fromJson(json['santri'] as Map<String, dynamic>),
      json['semester'] as int,
      json['tahun_ajaran'] as String,
      json['bulan'] as int,
      json['nama_variabel'] as String,
      json['nilai_mesjid'] as int,
      json['nilai_kelas'] as int,
      json['nilai_asrama'] as int,
      json['akumulatif'] as int,
      json['predikat'] as String,
    )..note = json['note'] as String;

Map<String, dynamic> _$NKToJson(NK instance) => <String, dynamic>{
      'id': instance.id,
      'santri': const SantriConverter().toJson(instance.santri),
      'semester': instance.semester,
      'tahun_ajaran': instance.tahun_ajaran,
      'bulan': instance.bulan,
      'nama_variabel': instance.nama_variabel,
      'nilai_mesjid': instance.nilai_mesjid,
      'nilai_kelas': instance.nilai_kelas,
      'nilai_asrama': instance.nilai_asrama,
      'akumulatif': instance.akumulatif,
      'predikat': instance.predikat,
      'note': instance.note,
    };
