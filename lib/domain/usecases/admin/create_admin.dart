
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/repositories/admin_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class CreateAdminUseCase extends BaseUseCase<RequestStatus, Admin, AdminRepository> {
  final AdminRepository repository;

  CreateAdminUseCase(this.repository) : super(repository, (repo, param) => repo.createAdmin(param));
}