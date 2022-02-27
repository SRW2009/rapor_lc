
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/repositories/nhb_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetNHBUseCase extends BaseUseCase<List<NHB>, String, NHBRepository> {
  NHBRepository repository;

  GetNHBUseCase(this.repository) : super(repository, (repo, param) => repo.getNHBList(param));
}