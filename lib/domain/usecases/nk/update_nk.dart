
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/repositories/nk_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class UpdateNKUseCase extends BaseUseCase<RequestStatus, NK, NKRepository> {
  NKRepository repository;

  UpdateNKUseCase(this.repository) : super(repository, (repo, param) => repo.updateNK(param));
}