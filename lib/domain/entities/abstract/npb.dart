

import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

abstract class NPB {
  abstract final int id;
  abstract final Santri santri;
  abstract final int semester;
  abstract final String tahunAjaran;
  abstract final MataPelajaran pelajaran;
  abstract final String presensi;
  abstract final String note;
}