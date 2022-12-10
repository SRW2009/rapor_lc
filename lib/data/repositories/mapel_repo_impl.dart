
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs.dart';
import 'package:rapor_lc/data/models/mata_pelajaran_model.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/mapel_repo.dart';

class MataPelajaranRepositoryImpl extends MataPelajaranRepository {

  @override
  String url = Urls.adminMapel;

  @override
  String altUrl = Urls.teacherMapel;

  @override
  Future<List<MataPelajaran>> getMataPelajaranList() async {
    final token = await SharedPrefs().getToken;

    await checkPrivilege();

    final response = await http.get(
      readUri(),
      headers: DataConstant.headers(token),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      var iterable =(jsonDecode(response.body) as List)
          .map<MataPelajaran>((e) => MataPelajaran.fromJson(e))
          .where((element) => element.divisi.name != 'Kesantrian');

      final user = repUser;
      if (user is Teacher) return iterable
          .where((element) => element.divisi.id == user.divisi.id
          || element.divisi.id == user.divisiBlock?.id)
          .toList();
      return iterable.toList();
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> createMataPelajaran(MataPelajaran mapel) async {
    final token = await SharedPrefs().getToken;

    await checkPrivilege();

    final response = await http.post(
      createUri(),
      headers: DataConstant.headers(token),
      body: jsonEncode(MataPelajaranModel.toJsonRequest(mapel)),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> updateMataPelajaran(MataPelajaran mapel) async {
    final token = await SharedPrefs().getToken;

    await checkPrivilege();

    final response = await http.put(
      updateUri(mapel.id),
      headers: DataConstant.headers(token),
      body: jsonEncode(MataPelajaranModel.toJsonRequest(mapel)),
    );
    if (response.statusCode == StatusCode.putSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteMataPelajaran(List<String> ids) async {
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

  @override
  Future<List<MataPelajaran>> getNKVariables() async {
    final token = await SharedPrefs().getToken;

    await checkPrivilege();

    final response = await http.get(
      readUri(),
      headers: DataConstant.headers(token),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      final list =(jsonDecode(response.body) as List)
          .map<MataPelajaran>((e) => MataPelajaran.fromJson(e))
          .where((element) => element.divisi.name == 'Kesantrian').toList();
      LoadedSettings.nkVariables = list.toList();

      return list;
    }
    throw Exception();
  }
}