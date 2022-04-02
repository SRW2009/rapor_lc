

import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(createFactory: false, createToJson: false)
abstract class NPB {
  final int no;
  @JsonKey(name: 'mapel')
  final MataPelajaran pelajaran;
  final String presensi;
  String note;
  final int n;

  NPB(this.no, this.pelajaran, this.presensi, this.note, this.n);

  static NPB fromJson(Map<String, dynamic> json) {
    if (json['n'] == -1) return NPBPO.fromJson(json);
    return NPBMO.fromJson(json);
  }
  Map<String, dynamic> toJson();
}

class NPBConverter implements JsonConverter<NPB, Map<String, dynamic>> {
  const NPBConverter();

  @override
  NPB fromJson(Map<String, dynamic> json) => NPB.fromJson(json);

  @override
  Map<String, dynamic> toJson(NPB object) => object.toJson();
}

class NullableNPBConverter implements JsonConverter<NPB?, Map<String, dynamic>?> {
  const NullableNPBConverter();

  @override
  NPB? fromJson(Map<String, dynamic>? json) => json != null ? NPB.fromJson(json) : null;

  @override
  Map<String, dynamic>? toJson(NPB? object) => object?.toJson();
}