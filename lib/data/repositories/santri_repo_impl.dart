
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/santri_repo.dart';

class SantriRepositoryImpl extends SantriRepository {
  @override
  String get url => Urls.adminStudent;

  @override
  Future<List<Santri>> getSantriList() async {
    final token = await SharedPrefs().getToken;

    // check request privilege
    final user = await SharedPrefs().getCurrentUser;
    if (user == null) throw Exception();
    Uri uri;
    if (user is Teacher) uri = Uri.parse(Urls.teacherGetStudent);
    else uri = readUri();

    final response = await http.get(
      uri,
      headers: DataConstant.headers(token),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Santri>((e) => Santri.fromJson(e)).toList();
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> createSantri(Santri santri) async {
    final token = await SharedPrefs().getToken;

    final response = await http.post(
      createUri(),
      headers: DataConstant.headers(token),
      body: jsonEncode(santri.toJson()),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> updateSantri(Santri santri) async {
    final token = await SharedPrefs().getToken;

    final response = await http.put(
      updateUri(santri.id),
      headers: DataConstant.headers(token),
      body: jsonEncode(santri.toJson()),
    );
    if (response.statusCode == StatusCode.putSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteSantri(List<String> ids) async {
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