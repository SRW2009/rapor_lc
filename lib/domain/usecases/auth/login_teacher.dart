
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/auth_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class LoginTeacherUseCase extends BaseUseCase<int, Teacher, AuthenticationRepository> {
  final AuthenticationRepository repository;

  LoginTeacherUseCase(this.repository) : super(repository, (repo, param) => repo.authenticateTeacher(email: param.email!, password: param.password!));
}