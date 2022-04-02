
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/repositories/teacher_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class DeleteTeacherUseCase extends BaseUseCase<RequestStatus, List<String>, TeacherRepository> {
  final TeacherRepository repository;

  DeleteTeacherUseCase(this.repository) : super(repository, (repo, param) => repo.deleteTeacher(param));
}