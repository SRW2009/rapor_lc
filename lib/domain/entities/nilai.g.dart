// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nilai.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nilai _$NilaiFromJson(Map<String, dynamic> json) => Nilai(
      json['id'] as int,
      const BaSConverter().fromJson(json['bulan'] as String),
      json['tahun_ajaran'] as String,
      const SantriConverter().fromJson(json['student'] as Map<String, dynamic>),
      nhb: (json['nhb'] as List<dynamic>?)
          ?.map((e) => const NHBConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      nk: (json['nk'] as List<dynamic>?)
          ?.map((e) => const NKConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      npb: (json['npb'] as List<dynamic>?)
          ?.map((e) => const NPBConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NilaiToJson(Nilai instance) => <String, dynamic>{
      'id': instance.id,
      'bulan': const BaSConverter().toJson(instance.BaS),
      'tahun_ajaran': instance.tahunAjaran,
      'student': const SantriConverter().toJson(instance.santri),
      'nhb': instance.nhb?.map(const NHBConverter().toJson).toList(),
      'nk': instance.nk?.map(const NKConverter().toJson).toList(),
      'npb': instance.npb?.map(const NPBConverter().toJson).toList(),
    };
