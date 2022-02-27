
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/repositories/nhb_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class DeleteNHBUseCase extends BaseUseCase<RequestStatus, int, NHBRepository> {
  NHBRepository repository;

  DeleteNHBUseCase(this.repository) : super(repository, (repo, param) => repo.deleteNHB(param));
}