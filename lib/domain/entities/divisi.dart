
import 'package:json_annotation/json_annotation.dart';

part 'divisi.g.dart';

@JsonSerializable()
class Divisi {
  final int id;
  final String name;

  const Divisi(this.id, this.name);

  factory Divisi.fromJson(Map<String, dynamic> json) => _$DivisiFromJson(json);
  Map<String, dynamic> toJson() => _$DivisiToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Divisi &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class DivisiConverter implements JsonConverter<Divisi, Map<String, dynamic>> {
  const DivisiConverter();

  @override
  Divisi fromJson(Map<String, dynamic> json) => Divisi.fromJson(json);

  @override
  Map<String, dynamic> toJson(Divisi object) => object.toJson();
}

class NullableDivisiConverter implements JsonConverter<Divisi?, Map<String, dynamic>?> {
  const NullableDivisiConverter();

  @override
  Divisi? fromJson(Map<String, dynamic>? json) => json != null ? Divisi.fromJson(json) : null;

  @override
  Map<String, dynamic>? toJson(Divisi? object) => object?.toJson();
}