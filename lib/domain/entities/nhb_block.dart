
import 'package:json_annotation/json_annotation.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

part 'nhb_block.g.dart';

@JsonSerializable()
class NHBBlock {
  final int no;
  @JsonKey(name: 'mapel')
  final MataPelajaran pelajaran;
  final int nilai_harian;
  final int nilai_projek;
  final int nilai_akhir;
  final int akumulasi;
  final String predikat;
  final String description;

  NHBBlock(this.no, this.pelajaran, this.nilai_harian, this.nilai_projek,
      this.nilai_akhir, this.akumulasi, this.predikat, this.description);

  factory NHBBlock.fromJson(Map<String, dynamic> json) => _$NHBBlockFromJson(json);
  Map<String, dynamic> toJson() => _$NHBBlockToJson(this);
}