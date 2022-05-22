
import 'package:rapor_lc/domain/entities/excel_obj.dart';
import 'package:rapor_lc/domain/repositories/excel_repo.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

class ExcelRepositoryImpl extends ExcelRepository {
  @override
  Future<bool> exportNilai(ExcelObject object) async {
    var excel = Excel.createExcel();
    return true;
  }

  @override
  Future<ExcelObject> importNilai() {
    // TODO: implement importNilai
    throw UnimplementedError();
  }

  @override
  String get url => throw UnimplementedError();
}