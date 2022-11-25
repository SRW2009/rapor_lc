// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting(
      json['id'] as int,
      json['variable'] as String,
      const _ValueConverter().fromJson(json['value'] as String),
    );

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'id': instance.id,
      'variable': instance.variable,
      'value': const _ValueConverter().toJson(instance.value),
    };
