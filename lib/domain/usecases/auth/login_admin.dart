
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/repositories/auth_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class LoginAdminUseCase extends BaseUseCase<int, Admin, AuthenticationRepository> {
  final AuthenticationRepository repository;

  LoginAdminUseCase(this.repository) : super(repository, (repo, param) => repo.authenticateAdmin(email: param.email!, password: param.password!));
}