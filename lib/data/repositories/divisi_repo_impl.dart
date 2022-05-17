
import 'dart:convert';

import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/repositories/divisi_repo.dart';
import 'package:http/http.dart' as http;

class DivisiRepositoryImpl extends DivisiRepository {
  @override
  String get url => Urls.adminDivisi;

  @override
  Future<List<Divisi>> getDivisiList() async {
    final token = await SharedPrefs().getToken;

    final response = await http.get(
      readUri(),
      headers: DataConstant.headers(token),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Divisi>((e) => Divisi.fromJson(e)).toList();
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> createDivisi(Divisi divisi) async {
    final token = await SharedPrefs().getToken;

    final response = await http.post(
      createUri(),
      headers: DataConstant.headers(token),
      body: jsonEncode(divisi.toJson()),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> updateDivisi(Divisi divisi) async {
    final token = await SharedPrefs().getToken;

    final response = await http.put(
      updateUri(divisi.id),
      headers: DataConstant.headers(token),
      body: jsonEncode(divisi.toJson()),
    );
    if (response.statusCode == StatusCode.putSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteDivisi(List<String> ids) async {
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