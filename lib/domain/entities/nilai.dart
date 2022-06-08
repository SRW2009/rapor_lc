
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
class Nilai implements Comparable {
  final int id;

  @BaSConverter()
  @JsonKey(name: 'semester')
  BulanAndSemester BaS;

  @JsonKey(name: 'year')
  String tahunAjaran;

  @JsonKey(name: 'student')
  Santri santri;

  List<NHB> nhb;
  List<NK> nk;
  List<NPB> npb;

  Nilai(this.id, this.BaS, this.tahunAjaran, this.santri, {this.nhb=const [], this.nk=const [], this.npb=const []});

  Nilai.empty() : id = -1, BaS = BulanAndSemester(0,0), tahunAjaran = '2021/2022',
        santri = Santri(0, ''), nhb=const [], nk=const [], npb=const [];

  factory Nilai.fromJson(Map<String, dynamic> json) => _$NilaiFromJson(json);
  Map<String, dynamic> toJson() => _$NilaiToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Nilai &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          BaS == other.BaS &&
          tahunAjaran == other.tahunAjaran &&
          santri == other.santri;

  @override
  int get hashCode =>
      id.hashCode ^ BaS.hashCode ^ tahunAjaran.hashCode ^ santri.hashCode;

  Nilai clone() => Nilai.fromJson(this.toJson());

  @override
  int compareTo(other) {
    if (other is! Nilai) throw TypeError();
    final thisVal = double.tryParse('${tahunAjaran.split('/')[0]}.${BaS.semester}${BaS.bulanFormatted()}') ?? 0;
    final otherVal = double.tryParse('${tahunAjaran.split('/')[0]}.${other.BaS.semester}${other.BaS.bulanFormatted()}') ?? 0;
    return thisVal.compareTo(otherVal);
  }
}

class NilaiConverter implements JsonConverter<Nilai, Map<String, dynamic>> {
  const NilaiConverter();

  @override
  Nilai fromJson(Map<String, dynamic> json) => Nilai.fromJson(json);

  @override
  Map<String, dynamic> toJson(Nilai object) => object.toJson();
}