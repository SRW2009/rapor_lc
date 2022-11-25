// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nhb_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NHBBlock _$NHBBlockFromJson(Map<String, dynamic> json) => NHBBlock(
      json['no'] as int,
      MataPelajaran.fromJson(json['mapel'] as Map<String, dynamic>),
      json['nilai_harian'] as int,
      json['nilai_projek'] as int,
      json['nilai_akhir'] as int,
      json['akumulasi'] as int,
      json['predikat'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$NHBBlockToJson(NHBBlock instance) => <String, dynamic>{
      'no': instance.no,
      'mapel': instance.pelajaran,
      'nilai_harian': instance.nilai_harian,
      'nilai_projek': instance.nilai_projek,
      'nilai_akhir': instance.nilai_akhir,
      'akumulasi': instance.akumulasi,
      'predikat': instance.predikat,
      'description': instance.description,
    };
