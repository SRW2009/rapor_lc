
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/user_repo.dart';

class UpdateUserUseCase extends BaseUseCase<RequestStatus, User, UserRepository> {
  UserRepository repository;

  UpdateUserUseCase(this.repository) : super(repository, (repo, param) => repo.updateUserAdmin(param));
}