
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/repositories/user_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetUserListAdminUseCase extends BaseUseCase<List<User>, int, UserRepository> {
  final UserRepository repository;

  GetUserListAdminUseCase(this.repository) : super(repository, (repo, param) => repo.getUserListAdmin(param));
}