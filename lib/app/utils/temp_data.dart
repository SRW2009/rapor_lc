
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class TempData {
  static List<Santri>? tempSantriList;
  static List<Nilai>? tempNilaiList;

  clear() {
    tempSantriList = null;
    tempNilaiList = null;
  }
}