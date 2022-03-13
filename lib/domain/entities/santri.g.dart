// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'santri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Santri _$SantriFromJson(Map<String, dynamic> json) => Santri(
      json['nis'] as String,
      json['nama'] as String,
      guru: json['guru'] == null ? null : User.fromJson(json['guru']),
      daftar_nhb: (json['daftar_nhb'] as List<dynamic>?)
          ?.map((e) => const NHBConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      daftar_nk: (json['daftar_nk'] as List<dynamic>?)
          ?.map((e) => const NKConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      daftar_npb: (json['daftar_npb'] as List<dynamic>?)
          ?.map((e) => const NPBConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SantriToJson(Santri instance) => <String, dynamic>{
      'nis': instance.nis,
      'nama': instance.nama,
      'guru': instance.guru,
      'daftar_nhb':
          instance.daftar_nhb?.map(const NHBConverter().toJson).toList(),
      'daftar_nk': instance.daftar_nk?.map(const NKConverter().toJson).toList(),
      'daftar_npb':
          instance.daftar_npb?.map(const NPBConverter().toJson).toList(),
    };
