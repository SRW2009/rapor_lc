
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/repositories/nhb_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetNHBListAdminUseCase extends BaseUseCase<List<NHB>, void, NHBRepository> {
  NHBRepository repository;

  GetNHBListAdminUseCase(this.repository) : super(repository, (repo, param) => repo.getNHBListAdmin());
}