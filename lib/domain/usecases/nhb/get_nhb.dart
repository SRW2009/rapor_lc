
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/repositories/nhb_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetNHBUseCase extends BaseUseCase<NHB, int, NHBRepository> {
  NHBRepository repository;

  GetNHBUseCase(this.repository) : super(repository, (repo, param) => repo.getNHB(param));
}