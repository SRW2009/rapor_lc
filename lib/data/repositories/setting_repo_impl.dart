
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs.dart';
import 'package:rapor_lc/domain/entities/setting.dart';
import 'package:rapor_lc/domain/repositories/setting_repo.dart';

class SettingRepositoryImpl extends SettingRepository {

  static final SettingRepositoryImpl _instance = SettingRepositoryImpl._internal();
  SettingRepositoryImpl._internal();
  factory SettingRepositoryImpl() => _instance;

  @override
  String url = Urls.adminSetting;

  @override
  String altUrl = Urls.teacherSetting;

  @override
  Future<List<Setting>> getSettingList() async {
    final token = await SharedPrefs().getToken;

    await checkPrivilege();

    final response = await http.get(
      readUri(),
      headers: DataConstant.headers(token),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      final list = (jsonDecode(response.body) as List)
          .map<Setting>((e) => Setting.fromJson(e)).toList();
      LoadedSettings.load(list);
      return list;
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> createSetting(Setting setting) async {
    final token = await SharedPrefs().getToken;

    await checkPrivilege();

    final response = await http.post(
      createUri(),
      headers: DataConstant.headers(token),
      body: jsonEncode(setting.toJson()),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> updateSetting(Setting setting) async {
    final token = await SharedPrefs().getToken;

    await checkPrivilege();

    final response = await http.put(
      updateUri(setting.id),
      headers: DataConstant.headers(token),
      body: jsonEncode(setting.toJson()),
    );
    if (response.statusCode == StatusCode.putSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteSetting(List<String> ids) async {
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