
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class NPBPO extends NPB {

  @override
  final int id;

  @override
  final MataPelajaran pelajaran;

  @override
  final String presensi;

  @override
  final Santri santri;

  @override
  final int semester;

  @override
  final String tahunAjaran;

  NPBPO(
      this.id,
      this.santri,
      this.semester,
      this.tahunAjaran,
      this.pelajaran,
      this.presensi
  );

  @override
  String note = '';
}