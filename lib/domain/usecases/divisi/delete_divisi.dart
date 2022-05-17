
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/repositories/divisi_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class DeleteDivisiUseCase extends BaseUseCase<RequestStatus, List<String>, DivisiRepository> {
  final DivisiRepository repository;

  DeleteDivisiUseCase(this.repository) : super(repository, (repo, param) => repo.deleteDivisi(param));
}