
import 'package:rapor_lc/domain/repositories/auth_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class LogoutUseCase extends BaseUseCase<void, void, AuthenticationRepository> {
  final AuthenticationRepository repository;

  LogoutUseCase(this.repository) : super(repository, (repo, param) => repo.logout());
}