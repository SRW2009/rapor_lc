
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/repositories/auth_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetCurrentUserUseCase extends BaseUseCase<User?, void, AuthenticationRepository> {
  final AuthenticationRepository repository;

  GetCurrentUserUseCase(this.repository) : super(repository, (repo, param) => repo.getCurrentUser());
}