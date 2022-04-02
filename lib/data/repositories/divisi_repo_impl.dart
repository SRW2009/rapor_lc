
import 'dart:convert';

import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/repositories/divisi_repo.dart';
import 'package:http/http.dart' as http;

class DivisiRepositoryImpl extends DivisiRepository {
  @override
  Future<RequestStatus> createDivisi(Divisi divisi) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          INSERT INTO tb_divisi (id, nama, kadiv) VALUES (NULL,'${divisi.name}','${divisi.kadiv}')
        ''',
      }),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteDivisi(List<String> ids) async {
    final token = await SharedPrefsRepository().getToken;

    final deleteQuery = ids.map<String>((e) =>
    'DELETE FROM tb_divisi WHERE id=$e'
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
  Future<Divisi> getDivisi(int id) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_get,
        'query': '''
          SELECT * FROM tb_divisi WHERE id=$id
        ''',
      }),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Divisi>((e) => Divisi.fromJson(e)).toList()[0];
    }
    throw Exception();
  }

  @override
  Future<List<Divisi>> getDivisiList() async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_get,
        'query': '''
          SELECT * FROM tb_divisi
        ''',
      }),
    );
    print(response.body);
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Divisi>((e) => Divisi.fromJson(e)).toList();
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> updateDivisi(Divisi divisi) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          UPDATE tb_divisi SET nama='${divisi.name}',kadiv='${divisi.kadiv}' WHERE id=${divisi.id}
        ''',
      }),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }
}