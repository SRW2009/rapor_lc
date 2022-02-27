
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/repositories/npb_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetNPBListUseCase extends BaseUseCase<List<NPB>, String, NPBRepository> {
  NPBRepository repository;

  GetNPBListUseCase(this.repository) : super(repository, (repo, param) => repo.getNPBList(param));
}