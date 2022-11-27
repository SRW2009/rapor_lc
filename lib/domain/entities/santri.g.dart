// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'santri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Santri _$SantriFromJson(Map<String, dynamic> json) => Santri(
      json['id'] as int,
      json['name'] as String,
      nis: json['nis'] as String?,
    );

Map<String, dynamic> _$SantriToJson(Santri instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nis': instance.nis,
    };
