
import 'package:rapor_lc/domain/entities/santri.dart';

class NK {
  final int id;
  final Santri santri;
  final int semester;
  final String tahunAjaran;
  final int bulan;
  final String variable;
  final int nilaiMesjid;
  final int nilaiKelas;
  final int nilaiAsrama;
  final int akumulatif;
  final String predikat;

  NK(
      this.id,
      this.santri,
      this.semester,
      this.tahunAjaran,
      this.bulan,
      this.variable,
      this.nilaiMesjid,
      this.nilaiKelas,
      this.nilaiAsrama,
      this.akumulatif,
      this.predikat);

  String note = '';
}