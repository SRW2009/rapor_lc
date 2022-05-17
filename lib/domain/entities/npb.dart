
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:json_annotation/json_annotation.dart';

part 'npb.g.dart';

@JsonSerializable()
@MataPelajaranConverter()
class NPB {
  final int no;
  @JsonKey(name: 'mapel')
  final MataPelajaran pelajaran;
  final String presensi;
  String note;

  NPB(this.no, this.pelajaran, this.presensi, {this.note=''});

  factory NPB.fromJson(Map<String, dynamic> json) => _$NPBFromJson(json);
  Map<String, dynamic> toJson() => _$NPBToJson(this);
}

class NPBConverter implements JsonConverter<NPB, Map<String, dynamic>> {
  const NPBConverter();

  @override
  NPB fromJson(Map<String, dynamic> json) => NPB.fromJson(json);

  @override
  Map<String, dynamic> toJson(NPB object) => object.toJson();
}

class NullableNPBConverter implements JsonConverter<NPB?, Map<String, dynamic>?> {
  const NullableNPBConverter();

  @override
  NPB? fromJson(Map<String, dynamic>? json) => json != null ? NPB.fromJson(json) : null;

  @override
  Map<String, dynamic>? toJson(NPB? object) => object?.toJson();
}