
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs.dart';
import 'package:rapor_lc/data/models/mata_pelajaran_model.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/mapel_repo.dart';

class MataPelajaranRepositoryImpl extends MataPelajaranRepository {
  @override
  String get url => Urls.adminMapel;

  @override
  Future<List<MataPelajaran>> getMataPelajaranList() async {
    final token = await SharedPrefs().getToken;

    // check request privilege
    final user = await SharedPrefs().getCurrentUser;
    if (user == null) throw Exception();
    Uri uri;
    if (user is Teacher) uri = Uri.parse(Urls.teacherGetMapel);
    else uri = readUri();

    final response = await http.get(
      uri,
      headers: DataConstant.headers(token),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      var iterable =(jsonDecode(response.body) as List)
          .map<MataPelajaran>((e) => MataPelajaranModel.fromJsonToEntity(e))
          .where((element) => element.divisi?.name != 'Kesantrian');

      if (user is Teacher) return iterable
          .where((element) => element.divisi?.id == user.divisi?.id)
          .toList();
      return iterable.toList();
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> createMataPelajaran(MataPelajaran mapel) async {
    final token = await SharedPrefs().getToken;

    final response = await http.post(
      createUri(),
      headers: DataConstant.headers(token),
      body: jsonEncode(MataPelajaranModel.fromEntityToJson(mapel)),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> updateMataPelajaran(MataPelajaran mapel) async {
    final token = await SharedPrefs().getToken;

    final response = await http.put(
      updateUri(mapel.id),
      headers: DataConstant.headers(token),
      body: jsonEncode(MataPelajaranModel.fromEntityToJson(mapel)),
    );
    if (response.statusCode == StatusCode.putSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteMataPelajaran(List<String> ids) async {
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

  @override
  Future<List<MataPelajaran>> getNKVariables() async {
    final token = await SharedPrefs().getToken;

    // check request privilege
    final user = await SharedPrefs().getCurrentUser;
    if (user == null) throw Exception();
    Uri uri;
    if (user is Teacher) uri = Uri.parse(Urls.teacherGetMapel);
    else uri = readUri();

    final response = await http.get(
      uri,
      headers: DataConstant.headers(token),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      var iterable =(jsonDecode(response.body) as List)
          .map<MataPelajaran>((e) => MataPelajaranModel.fromJsonToEntity(e))
          .where((element) => element.divisi?.name == 'Kesantrian');

      return iterable.toList();
    }
    throw Exception();
  }
}