
import 'package:json_annotation/json_annotation.dart';

part 'divisi.g.dart';

@JsonSerializable()
class Divisi {
  final int id;
  final String nama;
  final String kadiv;

  Divisi(this.id, this.nama, this.kadiv);

  factory Divisi.fromJson(Map<String, dynamic> json) => _$DivisiFromJson(json);
  Map<String, dynamic> toJson() => _$DivisiToJson(this);
}

class DivisiConverter implements JsonConverter<Divisi, Map<String, dynamic>> {
  const DivisiConverter();

  @override
  Divisi fromJson(Map<String, dynamic> json) => Divisi.fromJson(json);

  @override
  Map<String, dynamic> toJson(Divisi object) => object.toJson();
}