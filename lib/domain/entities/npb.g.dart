// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NPB _$NPBFromJson(Map<String, dynamic> json) => NPB(
      json['no'] as int,
      MataPelajaran.fromJson(json['mapel'] as Map<String, dynamic>),
      json['n'] as int,
    );

Map<String, dynamic> _$NPBToJson(NPB instance) => <String, dynamic>{
      'no': instance.no,
      'mapel': instance.pelajaran,
      'n': instance.n,
    };
