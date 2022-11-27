
import 'dart:io';

import 'package:rapor_lc/common/repository.dart';

abstract class ExcelRepository extends Repository {
  Stream<String?> importNilai(List<File> files);
  Future<List<int>?> exportNilai();
}