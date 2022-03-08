
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/divisi_repo.dart';

class UpdateDivisiUseCase extends BaseUseCase<RequestStatus, Divisi, DivisiRepository> {
  DivisiRepository repository;

  UpdateDivisiUseCase(this.repository) : super(repository, (repo, param) => repo.updateDivisi(param));
}