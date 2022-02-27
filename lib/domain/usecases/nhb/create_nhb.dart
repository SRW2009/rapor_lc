
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/repositories/nhb_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class CreateNHBUseCase extends BaseUseCase<RequestStatus, NHB, NHBRepository> {
  NHBRepository repository;

  CreateNHBUseCase(this.repository) : super(repository, (repo, param) => repo.createNHB(param));
}