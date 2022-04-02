
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/santri_repo.dart';

class UpdateSantriUseCase extends BaseUseCase<RequestStatus, Santri, SantriRepository> {
  SantriRepository repository;

  UpdateSantriUseCase(this.repository) : super(repository, (repo, param) => repo.updateSantri(param));
}