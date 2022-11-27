
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/admin_repo.dart';

class UpdateAdminUseCase extends BaseUseCase<RequestStatus, Admin, AdminRepository> {
  AdminRepository repository;

  UpdateAdminUseCase(this.repository) : super(repository, (repo, param) => repo.updateAdmin(param));
}