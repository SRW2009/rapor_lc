
import 'package:json_annotation/json_annotation.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';

part 'mata_pelajaran.g.dart';

@JsonSerializable()
@NullableDivisiConverter()
class MataPelajaran {
  final int id;
  final String name;
  Divisi? divisi;

  MataPelajaran(this.id, this.name, {this.divisi});

  factory MataPelajaran.fromJson(Map<String, dynamic> json) => _$MataPelajaranFromJson(json);
  Map<String, dynamic> toJson() => _$MataPelajaranToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MataPelajaran &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class MataPelajaranConverter implements JsonConverter<MataPelajaran, Map<String, dynamic>> {
  const MataPelajaranConverter();

  @override
  MataPelajaran fromJson(Map<String, dynamic> json) => MataPelajaran.fromJson(json);

  @override
  Map<String, dynamic> toJson(MataPelajaran object) => object.toJson();
}