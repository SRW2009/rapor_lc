
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';

class Santri {
  final String nis;
  final String nama;
  final List<NHB>? daftar_nhb;
  final List<NK>? daftar_nk;
  final NPBMO? npbmo;
  final List<NPBPO>? daftar_npbpo;

  const Santri(this.nis, this.nama, {
    this.daftar_nhb, this.daftar_nk,
    this.npbmo, this.daftar_npbpo,
  });
}