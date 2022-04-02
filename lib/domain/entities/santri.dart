
import 'package:json_annotation/json_annotation.dart';

part 'santri.g.dart';

@JsonSerializable()
class Santri {
  final int id;
  final String name;
  final String? nis;

  Santri(this.id, this.name, {this.nis});

  factory Santri.fromJson(Map<String, dynamic> json) => _$SantriFromJson(json);
  Map<String, dynamic> toJson() => _$SantriToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Santri &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class SantriConverter implements JsonConverter<Santri, Map<String, dynamic>> {
  const SantriConverter();

  @override
  Santri fromJson(Map<String, dynamic> json) => Santri.fromJson(json);

  @override
  Map<String, dynamic> toJson(Santri object) => object.toJson();
}