
import 'dart:convert';

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

  factory MataPelajaran.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return _$MataPelajaranFromJson(json);
    } else if (json is String) {
      Map<String, dynamic> newJson = jsonDecode(json);
      return _$MataPelajaranFromJson(newJson);
    }
    throw Exception('Parsing error');
  }
  Map<String, dynamic> toJson() => _$MataPelajaranToJson(this);
}

class MataPelajaranConverter implements JsonConverter<MataPelajaran, Map<String, dynamic>> {
  const MataPelajaranConverter();

  @override
  MataPelajaran fromJson(Map<String, dynamic> json) => MataPelajaran.fromJson(json);

  @override
  Map<String, dynamic> toJson(MataPelajaran object) => object.toJson();
}