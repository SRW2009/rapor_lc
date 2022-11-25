// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nilai.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nilai _$NilaiFromJson(Map<String, dynamic> json) => Nilai(
      json['id'] as int,
      const TimelineConverter().fromJson(json['semester'] as String),
      json['year'] as String,
      Santri.fromJson(json['student'] as Map<String, dynamic>),
      nhbSemester:
          (Nilai._readJsonNHBSemester(json, 'nhbSemester') as List<dynamic>?)
                  ?.map((e) => NHBSemester.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
      nhbBlock: (Nilai._readJsonNHBBlock(json, 'nhbBlock') as List<dynamic>?)
              ?.map((e) => NHBBlock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      nk: (json['nk'] as List<dynamic>?)
              ?.map((e) =>
                  const NKConverter().fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      npb: (json['npb'] as List<dynamic>?)
              ?.map((e) => NPB.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isObservation: json['is_observation'] as bool? ?? false,
    );
