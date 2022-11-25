
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/common/repository.dart';
import 'package:rapor_lc/domain/entities/setting.dart';

abstract class SettingRepository extends Repository {
  Future<List<Setting>> getSettingList();
  Future<RequestStatus> createSetting(Setting setting);
  Future<RequestStatus> updateSetting(Setting setting);
  Future<RequestStatus> deleteSetting(List<String> nisList);
}