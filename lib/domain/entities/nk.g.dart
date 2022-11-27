// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NK _$NKFromJson(Map<String, dynamic> json) => NK(
      json['no'] as int,
      json['nama_variabel'] as String,
      json['nilai_mesjid'] as int,
      json['nilai_kelas'] as int,
      json['nilai_asrama'] as int,
      json['akumulatif'] as int,
      json['predikat'] as String,
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$NKToJson(NK instance) => <String, dynamic>{
      'no': instance.no,
      'nama_variabel': instance.nama_variabel,
      'nilai_mesjid': instance.nilai_mesjid,
      'nilai_kelas': instance.nilai_kelas,
      'nilai_asrama': instance.nilai_asrama,
      'akumulatif': instance.akumulatif,
      'predikat': instance.predikat,
      'note': instance.note,
    };
