
import 'dart:convert';

import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/repositories/mapel_repo.dart';
import 'package:http/http.dart' as http;

class MataPelajaranRepositoryImpl extends MataPelajaranRepository {
  @override
  Future<RequestStatus> createMataPelajaran(MataPelajaran mapel) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          INSERT INTO tb_mata_pelajaran (id, divisi_id, nama_mapel) 
          VALUES (NULL,${mapel.divisi.id},'${mapel.nama_mapel}')
        ''',
      }),
    );

    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }

    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteMataPelajaran(List<String> ids) async {
    final token = await SharedPrefsRepository().getToken;

    final deleteQuery = ids.map<String>((e) =>
    'DELETE FROM tb_mata_pelajaran WHERE id=$e'
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
  Future<MataPelajaran> getMataPelajaran(int id) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_get,
        'query': '''
          SELECT id, nama_mapel, 
          (SELECT GROUP_CONCAT(JSON_OBJECT('id', tb_divisi.id, 'nama', tb_divisi.nama, 'kadiv', tb_divisi.kadiv)) 
          FROM tb_divisi WHERE tb_divisi.id=mapel.id) as divisi 
          FROM tb_mata_pelajaran as mapel 
          WHERE id=$id
        ''',
      }),
    );

    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<MataPelajaran>((e) => MataPelajaran.fromJson(e)).toList()[0];
    }

    throw Exception();
  }

  @override
  Future<List<MataPelajaran>> getMataPelajaranList() async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_get,
        'query': '''
          SELECT id, nama_mapel, 
          (SELECT GROUP_CONCAT(JSON_OBJECT('id', tb_divisi.id, 'nama', tb_divisi.nama, 'kadiv', tb_divisi.kadiv)) 
          FROM tb_divisi WHERE tb_divisi.id=mapel.id) as divisi 
          FROM tb_mata_pelajaran as mapel
        ''',
      }),
    );

    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<MataPelajaran>((e) => MataPelajaran.fromJson(e)).toList();
    }

    throw Exception();
  }

  @override
  Future<RequestStatus> updateMataPelajaran(MataPelajaran mapel) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          UPDATE tb_mata_pelajaran SET divisi_id=${mapel.divisi.id}, nama_mapel='${mapel.nama_mapel}' WHERE id=${mapel.id}
        ''',
      }),
    );

    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }

    return RequestStatus.failed;
  }
}