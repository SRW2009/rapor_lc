
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

import 'package:json_annotation/json_annotation.dart';

part 'npbmo.g.dart';

@JsonSerializable()
@SantriConverter()
@MataPelajaranConverter()
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
  final String tahun_ajaran;

  @override
  String note;

  NPBMO(
      this.id,
      this.santri,
      this.semester,
      this.tahun_ajaran,
      this.pelajaran,
      this.n,
      this.presensi,
      {this.note=''}
  );

  factory NPBMO.fromJson(Map<String, dynamic> json) => _$NPBMOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$NPBMOToJson(this);
}