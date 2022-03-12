
import 'dart:convert';

import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/repositories/divisi_repo.dart';
import 'package:http/http.dart' as http;

class DivisiRepositoryImpl extends DivisiRepository {
  @override
  Future<RequestStatus> createDivisi(Divisi divisi) {
    // TODO: implement createDivisi
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> deleteDivisi(List<String> ids) {
    // TODO: implement deleteDivisi
    throw UnimplementedError();
  }

  @override
  Future<Divisi> getDivisi(int id) {
    // TODO: implement getDivisi
    throw UnimplementedError();
  }

  @override
  Future<List<Divisi>> getDivisiList() async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query': 'SELECT * FROM tb_divisi',
      }),
    );

    if (response.statusCode == StatusCode.postSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Divisi>((e) => Divisi.fromJson(e)).toList();
    }

    throw Exception();
  }

  @override
  Future<RequestStatus> updateDivisi(Divisi divisi) {
    // TODO: implement updateDivisi
    throw UnimplementedError();
  }
}