
import 'package:rapor_lc/domain/entities/login_cred.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/login_repo.dart';

class DoLogin extends BaseUseCase<String, LoginCredentials, LoginRepository> {
  final LoginRepository loginRepository;

  DoLogin(this.loginRepository) : super(loginRepository, (repo, param) => repo.doLogin(param));
}