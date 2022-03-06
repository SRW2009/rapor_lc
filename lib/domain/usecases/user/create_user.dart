

import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/repositories/user_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class CreateUserUseCase extends BaseUseCase<RequestStatus, User, UserRepository> {
  final UserRepository repository;

  CreateUserUseCase(this.repository) : super(repository, (repo, param) => repo.createUserAdmin(param));
}