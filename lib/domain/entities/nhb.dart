
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

import 'package:json_annotation/json_annotation.dart';

part 'nhb.g.dart';

@JsonSerializable()
@SantriConverter()
@MataPelajaranConverter()
class NHB {
  final int id;
  final Santri santri;
  final int semester;
  final String tahun_ajaran;
  final MataPelajaran pelajaran;
  final int nilai_harian;
  final int nilai_bulanan;
  final int nilai_projek;
  final int nilai_akhir;
  final int akumulasi;
  final String predikat;

  NHB(
      this.id,
      this.santri,
      this.semester,
      this.tahun_ajaran,
      this.pelajaran,
      this.nilai_harian,
      this.nilai_bulanan,
      this.nilai_projek,
      this.nilai_akhir,
      this.akumulasi,
      this.predikat);

  factory NHB.fromJson(Map<String, dynamic> json) => _$NHBFromJson(json);
  Map<String, dynamic> toJson() => _$NHBToJson(this);
}

class NHBConverter implements JsonConverter<NHB, Map<String, dynamic>> {
  const NHBConverter();

  @override
  NHB fromJson(Map<String, dynamic> json) => NHB.fromJson(json);

  @override
  Map<String, dynamic> toJson(NHB object) => object.toJson();
}