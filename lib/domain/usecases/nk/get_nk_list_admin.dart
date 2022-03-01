
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/repositories/nk_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetNKListAdminUseCase extends BaseUseCase<List<NK>, void, NKRepository> {
  NKRepository repository;

  GetNKListAdminUseCase(this.repository) : super(repository, (repo, param) => repo.getNKListAdmin());
}