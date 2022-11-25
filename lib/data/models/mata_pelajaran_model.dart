
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

class MataPelajaranModel {
  static Map<String, dynamic> toJsonRequest(MataPelajaran e)  => {
    'name': e.name,
    'divisi_id': e.divisi.id,
  };
}