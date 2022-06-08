
import 'package:rapor_lc/domain/repositories/excel_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class ExportNilaiUseCase extends BaseUseCase<List<int>?, void, ExcelRepository>{
  ExportNilaiUseCase(ExcelRepository repo) : super(repo, (repo, param) => repo.exportNilai());
}