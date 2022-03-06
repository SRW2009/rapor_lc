

import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/user_repo.dart';

class GetUserListUseCase extends BaseUseCase<List<User>, int?, UserRepository> {
  UserRepository repository;

  GetUserListUseCase(this.repository) : super(repository, (repo, param) => repo.getUserListAdmin(param));
}