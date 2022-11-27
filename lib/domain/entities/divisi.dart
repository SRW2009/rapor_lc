
import 'package:json_annotation/json_annotation.dart';

part 'divisi.g.dart';

@JsonSerializable()
class Divisi {
  final int id;
  final String name;
  @JsonKey(name: 'is_block')
  final bool isBlock;

  const Divisi(this.id, this.name, this.isBlock);

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