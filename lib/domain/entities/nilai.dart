
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/domain/entities/bulan_and_semester.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

import 'package:json_annotation/json_annotation.dart';

part 'nilai.g.dart';

@JsonSerializable()
@SantriConverter()
@NHBConverter()
@NKConverter()
@NPBConverter()
class Nilai {
  final int id;

  @BaSConverter()
  @JsonKey(name: 'semester')
  final BulanAndSemester BaS;

  @JsonKey(name: 'year')
  final String tahunAjaran;

  @JsonKey(name: 'student')
  final Santri santri;

  List<NHB> nhb;
  List<NK> nk;
  List<NPB> npb;

  Nilai(this.id, this.BaS, this.tahunAjaran, this.santri, {this.nhb=const [], this.nk=const [], this.npb=const []});

  factory Nilai.fromJson(Map<String, dynamic> json) => _$NilaiFromJson(json);
  Map<String, dynamic> toJson() => _$NilaiToJson(this);
}

class NilaiConverter implements JsonConverter<Nilai, Map<String, dynamic>> {
  const NilaiConverter();

  @override
  Nilai fromJson(Map<String, dynamic> json) => Nilai.fromJson(json);

  @override
  Map<String, dynamic> toJson(Nilai object) => object.toJson();
}