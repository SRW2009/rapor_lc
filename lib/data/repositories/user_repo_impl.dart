
import 'dart:convert';

import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/admin_repo.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl extends AdminRepository {
  @override
  Future<RequestStatus> createAdmin(Teacher user) async {
    final token = await SharedPrefsRepository().getToken;

    final md5response = await http.post(
      DataConstant.getMd5Uri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'text': user.password
      }),
    );
    if (md5response.statusCode != StatusCode.getSuccess) {
      return RequestStatus.failed;
    }

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          INSERT INTO tb_user(email,password,status) VALUES ('${user.email}','${md5response.body}',${user.status})
        ''',
      }),
    );

    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }

    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteAdmin(List<String> emails) async {
    final token = await SharedPrefsRepository().getToken;

    final deleteQuery = emails.map<String>((e) =>
    'DELETE FROM tb_user WHERE email="$e"'
    ).join(';');
    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': deleteQuery,
      }),
    );

    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }

    return RequestStatus.failed;
  }

  @override
  Future<Teacher> getAdmin(String email) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_get,
        'query': '''
          SELECT * FROM tb_user WHERE email='$email'
        ''',
      }),
    );

    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Teacher>((e) => Teacher.fromJson(e)).toList()[0];
    }

    throw Exception();
  }

  @override
  Future<List<Teacher>> getAdminList([int? status=-1]) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_get,
        'query': '''
          SELECT * FROM tb_user
        ''',
      }),
    );

    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Teacher>((e) => Teacher.fromJson(e)).toList();
    }

    throw Exception();
  }

  @override
  Future<RequestStatus> updateAdmin(Teacher user) async {
    final token = await SharedPrefsRepository().getToken;

    final md5response = await http.post(
      DataConstant.getMd5Uri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'text': user.password
      }),
    );
    if (md5response.statusCode != StatusCode.getSuccess) {
      return RequestStatus.failed;
    }

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          UPDATE tb_user SET password='${md5response.body}',status='${user.status}' WHERE email='${user.email}'
        ''',
      }),
    );

    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }

    return RequestStatus.failed;
  }

}