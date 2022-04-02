
import 'dart:convert';

import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/santri_repo.dart';
import 'package:http/http.dart' as http;

class SantriRepositoryImpl extends SantriRepository {
  @override
  Future<RequestStatus> createSantri(Santri santri) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          INSERT INTO tb_santri(nis, nama, teacher_email) VALUES ('${santri.nis}','${santri.name}','${santri.guru?.email}')
        ''',
      }),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteSantri(List<String> nisList) async {
    final token = await SharedPrefsRepository().getToken;

    final deleteQuery = nisList.map<String>((e) =>
    'DELETE FROM tb_santri WHERE nis="$e"'
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
  Future<Santri> getSantri(String nis) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_get,
        'query': '''
          SELECT nis, nama, 
          (SELECT GROUP_CONCAT(JSON_OBJECT('email', tb_user.email, 'password', '', 'status', tb_user.status)) 
          FROM tb_user WHERE tb_user.email=tb_santri.teacher_email) as guru 
          FROM tb_santri 
          WHERE nis="$nis"
        ''',
      }),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Santri>((e) => Santri.fromJson(e)).toList()[0];
    }
    throw Exception();
  }

  @override
  Future<List<Santri>> getSantriList(Teacher guru) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_get,
        'query': '''
          SELECT nis, nama, 
          (SELECT GROUP_CONCAT(JSON_OBJECT('email', tb_user.email, 'password', '', 'status', tb_user.status)) 
          FROM tb_user WHERE tb_user.email=tb_santri.teacher_email) as guru 
          FROM tb_santri 
          WHERE teacher_email="${guru.email}"
        ''',
      }),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Santri>((e) => Santri.fromJson(e)).toList();
    }
    throw Exception();
  }

  @override
  Future<List<Santri>> getSantriListAdmin() async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_get,
        'query': '''
          SELECT nis, nama, 
          (SELECT GROUP_CONCAT(JSON_OBJECT('email', tb_user.email, 'password', '', 'status', tb_user.status)) 
          FROM tb_user WHERE tb_user.email=tb_santri.teacher_email) as guru 
          FROM tb_santri
        ''',
      }),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Santri>((e) => Santri.fromJson(e)).toList();
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> updateSantri(Santri santri) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          UPDATE tb_santri SET nama='${santri.name}',teacher_email='${santri.guru?.email}' WHERE nis="${santri.nis}"
        ''',
      }),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }
}