
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

@JsonSerializable()
class Setting {
  final int id;
  final String variable;

  @_ValueConverter()
  final dynamic value;

  Setting(this.id, this.variable, this.value);

  factory Setting.fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);
  Map<String, dynamic> toJson() => _$SettingToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Setting &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              variable == other.variable &&
              value == other.value;

  @override
  int get hashCode => variable.hashCode ^ value.hashCode;
}

class _ValueConverter implements JsonConverter<dynamic, String> {
  const _ValueConverter();

  @override
  dynamic fromJson(String json) => jsonDecode(json);

  @override
  String toJson(object) => jsonEncode(object);
}