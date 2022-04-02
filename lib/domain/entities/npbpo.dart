
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

import 'package:json_annotation/json_annotation.dart';
part 'npbpo.g.dart';

@JsonSerializable()
@MataPelajaranConverter()
class NPBPO extends NPB {
  NPBPO(int no, MataPelajaran pelajaran, String presensi, {String note=''})
      : super(no, pelajaran, presensi, note, -1);

  factory NPBPO.fromJson(Map<String, dynamic> json) => _$NPBPOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$NPBPOToJson(this);
}