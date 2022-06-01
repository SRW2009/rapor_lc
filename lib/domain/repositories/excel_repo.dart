
import 'dart:io';

import 'package:rapor_lc/common/repository.dart';
import 'package:rapor_lc/domain/entities/excel_obj.dart';

abstract class ExcelRepository extends Repository {
  Stream<String?> importNilai(List<File> files);
  Future<bool> exportNilai(ExcelObject object);
}