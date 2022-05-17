
import 'package:rapor_lc/domain/entities/excel_obj.dart';
import 'package:rapor_lc/domain/repositories/excel_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class ImportNilaiUseCase extends BaseUseCase<ExcelObject, void, ExcelRepository>{
  ImportNilaiUseCase(ExcelRepository repo) : super(repo, (repo, param) => repo.importNilai());
}