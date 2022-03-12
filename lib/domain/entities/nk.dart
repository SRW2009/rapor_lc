
import 'package:rapor_lc/domain/entities/santri.dart';

import 'package:json_annotation/json_annotation.dart';

part 'nk.g.dart';

@JsonSerializable()
@SantriConverter()
class NK {
  final int id;
  final Santri santri;
  final int semester;
  final String tahun_ajaran;
  final int bulan;
  final String nama_variabel;
  final int nilai_mesjid;
  final int nilai_kelas;
  final int nilai_asrama;
  final int akumulatif;
  final String predikat;
  String note = '';

  NK(
      this.id,
      this.santri,
      this.semester,
      this.tahun_ajaran,
      this.bulan,
      this.nama_variabel,
      this.nilai_mesjid,
      this.nilai_kelas,
      this.nilai_asrama,
      this.akumulatif,
      this.predikat);

  factory NK.fromJson(Map<String, dynamic> json) => _$NKFromJson(json);
  Map<String, dynamic> toJson() => _$NKToJson(this);
}

class NKConverter implements JsonConverter<NK, Map<String, dynamic>> {
  const NKConverter();

  @override
  NK fromJson(Map<String, dynamic> json) => NK.fromJson(json);

  @override
  Map<String, dynamic> toJson(NK object) => object.toJson();
}