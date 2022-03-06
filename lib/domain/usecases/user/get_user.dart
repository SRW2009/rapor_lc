
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/user_repo.dart';

class GetUserUseCase extends BaseUseCase<User, String, UserRepository> {
  UserRepository repository;

  GetUserUseCase(this.repository) : super(repository, (repo, param) => repo.getUserAdmin(param));
}