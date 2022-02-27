
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/santri_repo.dart';

class GetSantriUseCase extends BaseUseCase<Santri, String, SantriRepository> {
  SantriRepository repository;

  GetSantriUseCase(this.repository) : super(repository, (repo, param) => repo.getSantri(param));
}