

import 'package:rapor_lc/domain/entities/setting.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/setting_repo.dart';

class GetSettingListUseCase extends BaseUseCase<List<Setting>, void, SettingRepository> {
  SettingRepository repository;

  GetSettingListUseCase(this.repository) : super(repository, (repo, param) => repo.getSettingList());
}