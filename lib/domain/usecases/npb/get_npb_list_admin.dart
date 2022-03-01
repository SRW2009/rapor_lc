
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/repositories/npb_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetNPBListAdminUseCase extends BaseUseCase<List<NPB>, void, NPBRepository> {
  NPBRepository repository;

  GetNPBListAdminUseCase(this.repository) : super(repository, (repo, param) => repo.getNPBListAdmin());
}