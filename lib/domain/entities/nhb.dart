
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class NHB {
  final int id;
  final Santri santri;
  final MataPelajaran mataPelajaran;
  final int semester;
  final String tahunAjaran;
  final int nilaiHarian;
  final int nilaiBulanan;
  final int nilaiProject;
  final int nilaiAkhir;
  final int akumulasi;
  final String predikat;

  NHB(
      this.id,
      this.santri,
      this.mataPelajaran,
      this.semester,
      this.tahunAjaran,
      this.nilaiHarian,
      this.nilaiBulanan,
      this.nilaiProject,
      this.nilaiAkhir,
      this.akumulasi,
      this.predikat,
      );
}