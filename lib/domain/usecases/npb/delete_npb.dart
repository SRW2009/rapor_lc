
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/repositories/npb_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class DeleteNPBUseCase extends BaseUseCase<RequestStatus, int, NPBRepository> {
  NPBRepository repository;

  DeleteNPBUseCase(this.repository) : super(repository, (repo, param) => repo.deleteNPB(param));
}