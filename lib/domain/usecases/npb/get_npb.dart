
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/repositories/npb_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetNPBUseCase extends BaseUseCase<NPB, int, NPBRepository> {
  NPBRepository repository;

  GetNPBUseCase(this.repository) : super(repository, (repo, param) => repo.getNPB(param));
}