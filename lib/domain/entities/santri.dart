
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';

class Santri {
  final String nis;
  final String nama;
  final User? guru;
  final List<NHB>? daftar_nhb;
  final List<NK>? daftar_nk;
  final List<NPB>? daftar_npb;

  Santri(this.nis, this.nama, {
    this.guru, this.daftar_nhb,
    this.daftar_nk, this.daftar_npb,
  });
}