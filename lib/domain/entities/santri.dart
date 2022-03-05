
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';
import 'package:rapor_lc/domain/entities/user.dart';

import 'abstract/npb.dart';

class Santri {
  final String nis;
  final String nama;
  final List<NHB>? daftar_nhb;
  final List<NK>? daftar_nk;
  final List<NPB>? daftar_npb;
  final User? guru;

  Santri(this.nis, this.nama, {
    this.daftar_nhb, this.daftar_nk,
    this.daftar_npb, this.guru,
  });
}