

import 'package:equatable/equatable.dart';
import 'package:rapor_lc/data/models/mata_pelajaran_model.dart';
import 'package:rapor_lc/data/models/npbmo_model.dart';
import 'package:rapor_lc/data/models/npbpo_model.dart';
import 'package:rapor_lc/data/models/santri_model.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';

abstract class NPBModel extends Equatable {
  abstract final int id;
  abstract final SantriModel santri;
  abstract final int semester;
  abstract final String tahunAjaran;
  abstract final MataPelajaranModel pelajaran;
  abstract final String presensi;
  abstract final String note;

  static NPBModel fromJson(e) {
    if (e['n'] == -1) return NPBMOModel.fromJson(e);
    return NPBPOModel.fromJson(e);
  }

  Map<String, dynamic> toJson();
  NPB toEntity();
}