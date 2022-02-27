
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/repositories/npb_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class CreateNPBUseCase extends BaseUseCase<RequestStatus, NPB, NPBRepository> {
  NPBRepository repository;

  CreateNPBUseCase(this.repository) : super(repository, (repo, param) => repo.createNPB(param));
}