

import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repositories/santri_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class CreateSantriUseCase extends BaseUseCase<RequestStatus, Santri, SantriRepository> {
  final SantriRepository repository;

  CreateSantriUseCase(this.repository) : super(repository, (repo, param) => repo.createSantri(param));
}