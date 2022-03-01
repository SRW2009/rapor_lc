
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/santri_repo.dart';

class GetSantriListAdminUseCase extends BaseUseCase<List<Santri>, void, SantriRepository> {
  SantriRepository repository;

  GetSantriListAdminUseCase(this.repository) : super(repository, (repo, param) => repo.getSantriListAdmin());
}