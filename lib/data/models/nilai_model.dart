
import 'package:rapor_lc/domain/entities/nilai.dart';

class NilaiModel {
  static Map<String, dynamic> toJson(Nilai instance)  => {
    'id': instance.id,
    'semester': instance.timeline.toString(),
    'year': instance.tahunAjaran,
    'student': instance.santri.toJson(),
    'is_observation': instance.isObservation,
    'nhb': {
      'semester': instance.nhbSemester.map((e) => e.toJson()).toList(),
      'block': instance.nhbBlock.map((e) => e.toJson()).toList(),
    },
    'nk': instance.nk.map((e) => e.toJson()).toList(),
    'npb': instance.npb.map((e) => e.toJson()).toList(),
  };
  static Map<String, dynamic> toJsonRequest(Nilai instance)  => {
    'id': instance.id,
    'semester': instance.timeline.toString(),
    'year': instance.tahunAjaran,
    'student_id': instance.santri.id,
    'is_observation': instance.isObservation,
    'nhb': {
      'semester': instance.nhbSemester.map((e) => e.toJson()).toList(),
      'block': instance.nhbBlock.map((e) => e.toJson()).toList(),
    },
    'nk': instance.nk.map((e) => e.toJson()).toList(),
    'npb': instance.npb.map((e) => e.toJson()).toList(),
  };
}