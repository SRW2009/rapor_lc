
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/teacher_repo.dart';
import 'package:rapor_lc/dummy_data/dummies.dart' as d;

class TeacherRepositoryImplTest extends TeacherRepository {
  final List<Teacher> teacherList;

  // singleton
  TeacherRepositoryImplTest._internal()
      : teacherList = [...d.teacherList];
  static final TeacherRepositoryImplTest _instance = TeacherRepositoryImplTest._internal();
  factory TeacherRepositoryImplTest() => _instance;

  @override
  Future<RequestStatus> createTeacher(Teacher user) =>
      Future.delayed(DataConstant.test_duration, () async {
        final item = Teacher.fromJson(user.toJson()..['id']=teacherList.length);
        teacherList.add(item);
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<RequestStatus> deleteTeacher(List<String> ids) async =>
      Future.delayed(DataConstant.test_duration, () async {
        teacherList.removeWhere((element) => ids.contains(element.id.toString()));
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<List<Teacher>> getTeacherList() async =>
      Future.delayed(DataConstant.test_duration, () async {
        return teacherList;
        //failed
        throw Exception();
      });

  @override
  Future<RequestStatus> updateTeacher(Teacher user) async =>
      Future.delayed(DataConstant.test_duration, () async {
        final index = teacherList.indexOf(user);
        teacherList.replaceRange(
          index, index+1, [user]
        );
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  String get url => throw UnimplementedError();
}