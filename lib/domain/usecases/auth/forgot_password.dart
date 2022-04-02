
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/auth_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class ForgotPasswordUseCase extends BaseUseCase<bool, String, AuthenticationRepository> {
  final AuthenticationRepository repository;

  ForgotPasswordUseCase(this.repository) : super(repository, (repo, param) => repo.forgotPassword(param));
}