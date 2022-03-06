
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/repositories/user_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class DeleteUserUseCase extends BaseUseCase<RequestStatus, List<String>, UserRepository> {
  final UserRepository repository;

  DeleteUserUseCase(this.repository) : super(repository, (repo, param) => repo.deleteUserAdmin(param));
}