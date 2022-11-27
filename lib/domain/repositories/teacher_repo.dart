
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/common/repository.dart';

abstract class TeacherRepository extends Repository {
  Future<List<Teacher>> getTeacherList();
  Future<RequestStatus> createTeacher(Teacher user);
  Future<RequestStatus> updateTeacher(Teacher user);
  Future<RequestStatus> deleteTeacher(List<String> ids);
}