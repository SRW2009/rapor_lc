
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/login_cred.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> doLogin(LoginCredentials loginCredentials);
}
