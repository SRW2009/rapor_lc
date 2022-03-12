
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

import 'package:json_annotation/json_annotation.dart';

part 'npbpo.g.dart';

@JsonSerializable()
@SantriConverter()
@MataPelajaranConverter()
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
  final String tahun_ajaran;

  @override
  String note;

  NPBPO(
      this.id,
      this.santri,
      this.semester,
      this.tahun_ajaran,
      this.pelajaran,
      this.presensi,
      {this.note=''}
  );

  factory NPBPO.fromJson(Map<String, dynamic> json) => _$NPBPOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$NPBPOToJson(this);
}