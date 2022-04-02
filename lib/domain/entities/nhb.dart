
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

import 'package:json_annotation/json_annotation.dart';

part 'nhb.g.dart';

@JsonSerializable()
@MataPelajaranConverter()
class NHB {
  final int no;
  @JsonKey(name: 'mapel')
  final MataPelajaran pelajaran;
  final int nilai_harian;
  final int nilai_bulanan;
  final int nilai_projek;
  final int nilai_akhir;
  final int akumulasi;
  final String predikat;

  NHB(
      this.no,
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

class NullableNHBConverter implements JsonConverter<NHB?, Map<String, dynamic>?> {
  const NullableNHBConverter();

  @override
  NHB? fromJson(Map<String, dynamic>? json) => json != null ? NHB.fromJson(json) : null;

  @override
  Map<String, dynamic>? toJson(NHB? object) => object?.toJson();
}