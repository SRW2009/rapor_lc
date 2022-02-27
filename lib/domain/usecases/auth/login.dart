
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/repositories/auth_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class LoginUseCase extends BaseUseCase<void, User, AuthenticationRepository> {
  final AuthenticationRepository repository;

  LoginUseCase(this.repository) : super(repository, (repo, param) => repo.authenticate(email: param.email, password: param.password));
}