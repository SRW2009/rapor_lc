
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/teacher_repo.dart';

class GetTeacherListUseCase extends BaseUseCase<List<Teacher>, void, TeacherRepository> {
  TeacherRepository repository;

  GetTeacherListUseCase(this.repository) : super(repository, (repo, param) => repo.getTeacherList());
}