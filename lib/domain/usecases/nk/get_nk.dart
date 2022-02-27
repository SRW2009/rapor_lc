
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/repositories/nk_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetNKUseCase extends BaseUseCase<NK, int, NKRepository> {
  NKRepository repository;

  GetNKUseCase(this.repository) : super(repository, (repo, param) => repo.getNK(param));
}