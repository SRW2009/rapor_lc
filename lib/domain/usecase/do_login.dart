
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/login_cred.dart';
import 'package:rapor_lc/domain/repository/login_repo.dart';

class DoLogin {
  final LoginRepository repository;

  DoLogin(this.repository);

  Future<Either<Failure, String>> execute(LoginCredentials login) {
    return repository.doLogin(login);
  }
}