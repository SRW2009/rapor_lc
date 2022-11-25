
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/setting.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/setting_repo.dart';

class UpdateSettingUseCase extends BaseUseCase<RequestStatus, Setting, SettingRepository> {
  SettingRepository repository;

  UpdateSettingUseCase(this.repository) : super(repository, (repo, param) => repo.updateSetting(param));
}