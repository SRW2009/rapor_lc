
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs.dart';
import 'package:rapor_lc/data/models/nilai_model.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/repositories/nilai_repo.dart';

class NilaiRepositoryImpl extends NilaiRepository {

  @override
  String url = Urls.adminNilai;

  @override
  String altUrl = Urls.teacherNilai;

  @override
  Future<List<Nilai>> getNilaiList() async {
    final token = await SharedPrefs().getToken;

    await checkPrivilege();

    final response = await http.get(
      readUri(),
      headers: DataConstant.headers(token),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Nilai>((e) => Nilai.fromJson(e)).toList();
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> createNilai(Nilai nilai) async {
    final token = await SharedPrefs().getToken;

    await checkPrivilege();

    final response = await http.post(
      createUri(),
      headers: DataConstant.headers(token),
      body: jsonEncode(NilaiModel.toJsonRequest(nilai)),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> updateNilai(Nilai nilai) async {
    final token = await SharedPrefs().getToken;

    await checkPrivilege();

    final response = await http.put(
      updateUri(nilai.id),
      headers: DataConstant.headers(token),
      body: jsonEncode(NilaiModel.toJsonRequest(nilai)),
    );
    if (response.statusCode == StatusCode.putSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteNilai(List<String> ids) async {
    final token = await SharedPrefs().getToken;

    await checkPrivilege();

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