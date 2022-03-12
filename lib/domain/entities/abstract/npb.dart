

import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

import 'package:json_annotation/json_annotation.dart';

abstract class NPB {
  abstract final int id;
  abstract final Santri santri;
  abstract final int semester;
  abstract final String tahun_ajaran;
  abstract final MataPelajaran pelajaran;
  abstract final String presensi;
  abstract final String note;

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