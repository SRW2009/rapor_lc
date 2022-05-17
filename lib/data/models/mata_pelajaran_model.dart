
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

class MataPelajaranModel {
  static MataPelajaran fromJsonToEntity(Map<String, dynamic> e) => MataPelajaran(
    e['id'],
    e['name'],
    divisi: Divisi.fromJson(e['divisi_detail']),
  );
  static Map<String, dynamic> fromEntityToJson(MataPelajaran e)  => {
    'name': e.name,
    'divisi_id': e.divisi?.id,
  };
}