
import 'package:rapor_lc/domain/entities/nilai.dart';

class NilaiModel {
  static Map<String, dynamic> fromEntityToJson(Nilai e)  => {
    'semester': e.BaS.toString(),
    'year': e.tahunAjaran,
    'student_id': e.santri.id,
    'npb': e.npb,
    'nhb': e.nhb,
    'nk': e.nk
  };
}