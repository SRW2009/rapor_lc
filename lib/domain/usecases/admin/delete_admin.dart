
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/repositories/admin_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class DeleteAdminUseCase extends BaseUseCase<RequestStatus, List<String>, AdminRepository> {
  final AdminRepository repository;

  DeleteAdminUseCase(this.repository) : super(repository, (repo, param) => repo.deleteAdmin(param));
}