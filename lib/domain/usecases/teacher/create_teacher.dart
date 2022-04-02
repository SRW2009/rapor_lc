

import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/teacher_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class CreateTeacherUseCase extends BaseUseCase<RequestStatus, Teacher, TeacherRepository> {
  final TeacherRepository repository;

  CreateTeacherUseCase(this.repository) : super(repository, (repo, param) => repo.createTeacher(param));
}