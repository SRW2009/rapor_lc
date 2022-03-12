
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mata_pelajaran.g.dart';

@JsonSerializable()
@DivisiConverter()
class MataPelajaran {
  final int id;
  final Divisi divisi;
  final String nama_mapel;

  MataPelajaran(this.id, this.divisi, this.nama_mapel);

  factory MataPelajaran.fromJson(Map<String, dynamic> json) => _$MataPelajaranFromJson(json);
  Map<String, dynamic> toJson() => _$MataPelajaranToJson(this);
}

class MataPelajaranConverter implements JsonConverter<MataPelajaran, Map<String, dynamic>> {
  const MataPelajaranConverter();

  @override
  MataPelajaran fromJson(Map<String, dynamic> json) => MataPelajaran.fromJson(json);

  @override
  Map<String, dynamic> toJson(MataPelajaran object) => object.toJson();
}