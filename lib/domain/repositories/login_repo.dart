
import 'package:rapor_lc/domain/entities/login_cred.dart';

import '../usecases/base_use_case.dart';

abstract class LoginRepository extends Repository {
  Future<String> doLogin(LoginCredentials loginCredentials);
}
