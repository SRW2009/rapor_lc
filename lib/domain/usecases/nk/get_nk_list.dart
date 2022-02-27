
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/repositories/nk_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetNKListUseCase extends BaseUseCase<List<NK>, String, NKRepository> {
  NKRepository repository;

  GetNKListUseCase(this.repository) : super(repository, (repo, param) => repo.getNKList(param));
}