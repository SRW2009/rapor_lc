
import 'package:rapor_lc/common/repository.dart';
import 'package:rapor_lc/domain/entities/excel_obj.dart';

abstract class ExcelRepository extends Repository {
  Future<bool> exportNilai(ExcelObject object);
  Future<ExcelObject> importNilai();
}