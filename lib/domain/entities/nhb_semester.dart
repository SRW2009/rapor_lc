
import 'package:json_annotation/json_annotation.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

part 'nhb_semester.g.dart';

@JsonSerializable()
class NHBSemester {
  final int no;
  @JsonKey(name: 'mapel')
  final MataPelajaran pelajaran;
  final int nilai_harian;
  final int nilai_bulanan;
  final int nilai_projek;
  final int nilai_akhir;
  final int akumulasi;
  final String predikat;

  NHBSemester(
      this.no,
      this.pelajaran,
      this.nilai_harian,
      this.nilai_bulanan,
      this.nilai_projek,
      this.nilai_akhir,
      this.akumulasi,
      this.predikat);

  factory NHBSemester.fromJson(Map<String, dynamic> json) => _$NHBSemesterFromJson(json);
  Map<String, dynamic> toJson() => _$NHBSemesterToJson(this);
}