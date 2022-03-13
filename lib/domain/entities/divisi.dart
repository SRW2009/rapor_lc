
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'divisi.g.dart';

@JsonSerializable()
class Divisi {
  final int id;
  final String nama;
  final String kadiv;

  Divisi(this.id, this.nama, this.kadiv);

  factory Divisi.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return _$DivisiFromJson(json);
    } else if (json is String) {
      Map<String, dynamic> newJson = jsonDecode(json);
      return _$DivisiFromJson(newJson);
    }
    throw Exception('Parsing error');
  }
  Map<String, dynamic> toJson() => _$DivisiToJson(this);
}

class DivisiConverter implements JsonConverter<Divisi, Map<String, dynamic>> {
  const DivisiConverter();

  @override
  Divisi fromJson(Map<String, dynamic> json) => Divisi.fromJson(json);

  @override
  Map<String, dynamic> toJson(Divisi object) => object.toJson();
}