
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

import 'package:json_annotation/json_annotation.dart';
part 'npbmo.g.dart';

@JsonSerializable()
@MataPelajaranConverter()
class NPBMO extends NPB {
  NPBMO(int no, MataPelajaran pelajaran, String presensi, int n, {String note=''})
      : super(no, pelajaran, presensi, note, n);

  factory NPBMO.fromJson(Map<String, dynamic> json) => _$NPBMOFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$NPBMOToJson(this);
}