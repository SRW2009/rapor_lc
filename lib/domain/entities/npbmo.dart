
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class NPBMO extends NPB {
  final int n;

  @override
  final int id;

  @override
  final String presensi;

  @override
  final Santri santri;

  @override
  final int semester;

  @override
  final MataPelajaran pelajaran;

  @override
  final String tahunAjaran;

  NPBMO(
      this.id,
      this.santri,
      this.semester,
      this.tahunAjaran,
      this.pelajaran,
      this.presensi,
      this.n,
      {this.note=''}
  );

  @override
  String note;
}