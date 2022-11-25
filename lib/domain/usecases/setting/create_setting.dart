
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/setting.dart';
import 'package:rapor_lc/domain/repositories/setting_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class CreateSettingUseCase extends BaseUseCase<RequestStatus, Setting, SettingRepository> {
  final SettingRepository repository;

  CreateSettingUseCase(this.repository) : super(repository, (repo, param) => repo.createSetting(param));
}