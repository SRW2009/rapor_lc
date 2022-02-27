
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/repositories/nk_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class CreateNKUseCase extends BaseUseCase<RequestStatus, NK, NKRepository> {
  NKRepository repository;

  CreateNKUseCase(this.repository) : super(repository, (repo, param) => repo.createNK(param));
}