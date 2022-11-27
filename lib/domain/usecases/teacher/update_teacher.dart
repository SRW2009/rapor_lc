
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/teacher_repo.dart';

class UpdateTeacherUseCase extends BaseUseCase<RequestStatus, Teacher, TeacherRepository> {
  TeacherRepository repository;

  UpdateTeacherUseCase(this.repository) : super(repository, (repo, param) => repo.updateTeacher(param));
}