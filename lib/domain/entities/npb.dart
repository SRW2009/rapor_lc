
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:json_annotation/json_annotation.dart';

part 'npb.g.dart';

@JsonSerializable()
class NPB {
  final int no;
  @JsonKey(name: 'mapel')
  final MataPelajaran pelajaran;
  final int n;

  NPB(this.no, this.pelajaran, this.n);

  factory NPB.fromJson(Map<String, dynamic> json) => _$NPBFromJson(json);
  Map<String, dynamic> toJson() => _$NPBToJson(this);
}