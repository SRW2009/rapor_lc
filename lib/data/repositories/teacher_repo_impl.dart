
import 'dart:convert';

import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs.dart';
import 'package:rapor_lc/data/models/teacher_model.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/teacher_repo.dart';
import 'package:http/http.dart' as http;

class TeacherRepositoryImpl extends TeacherRepository {
  @override
  String get url => Urls.adminTeacher;

  @override
  Future<List<Teacher>> getTeacherList() async {
    final token = await SharedPrefs().getToken;

    final response = await http.get(
      readUri(),
      headers: DataConstant.headers(token),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Teacher>((e) => TeacherModel.fromJsonToEntity(e)).toList();
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> createTeacher(Teacher teacher) async {
    final token = await SharedPrefs().getToken;

    final response = await http.post(
      createUri(),
      headers: DataConstant.headers(token),
      body: jsonEncode(TeacherModel.fromEntityToJson(teacher)),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> updateTeacher(Teacher teacher) async {
    final token = await SharedPrefs().getToken;

    final response = await http.put(
      updateUri(teacher.id),
      headers: DataConstant.headers(token),
      body: jsonEncode(TeacherModel.fromEntityToJson(teacher)),
    );
    if (response.statusCode == StatusCode.putSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteTeacher(List<String> ids) async {
    final token = await SharedPrefs().getToken;

    bool success = true;
    for (var id in ids) {
      final response = await http.delete(
        deleteUri(id),
        headers: DataConstant.headers(token),
      );

      if (response.statusCode != StatusCode.deleteSuccess) {
        success = false;
        break;
      }
    }
    if (success) return RequestStatus.success;
    return RequestStatus.failed;
  }
}