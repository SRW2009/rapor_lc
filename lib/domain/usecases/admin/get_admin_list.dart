

import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/admin_repo.dart';

class GetAdminListUseCase extends BaseUseCase<List<Admin>, void, AdminRepository> {
  AdminRepository repository;

  GetAdminListUseCase(this.repository) : super(repository, (repo, param) => repo.getAdminList());
}