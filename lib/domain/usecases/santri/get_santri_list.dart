
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/santri_repo.dart';

class GetSantriListUseCase extends BaseUseCase<List<Santri>, bool?, SantriRepository> {
  SantriRepository repository;

  GetSantriListUseCase(this.repository) : super(repository, (repo, param) => repo.getSantriList());
}