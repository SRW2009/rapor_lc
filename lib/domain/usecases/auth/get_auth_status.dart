
import 'package:rapor_lc/domain/repositories/auth_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetAuthStatusUseCase extends BaseUseCase<int, void, AuthenticationRepository> {
  final AuthenticationRepository repository;

  GetAuthStatusUseCase(this.repository) : super(repository, (repo, param) => repo.isAuthenticated());
}