
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class ExcelObject {
  final Santri santri;
  final List<Nilai> nilaiList;

  ExcelObject(this.santri, this.nilaiList);
}