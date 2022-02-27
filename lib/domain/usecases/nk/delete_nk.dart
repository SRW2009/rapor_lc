
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/repositories/nk_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class DeleteNKUseCase extends BaseUseCase<RequestStatus, int, NKRepository> {
  NKRepository repository;

  DeleteNKUseCase(this.repository) : super(repository, (repo, param) => repo.deleteNK(param));
}