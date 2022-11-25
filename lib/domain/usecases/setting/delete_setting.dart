
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/repositories/setting_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class DeleteSettingUseCase extends BaseUseCase<RequestStatus, List<String>, SettingRepository> {
  final SettingRepository repository;

  DeleteSettingUseCase(this.repository) : super(repository, (repo, param) => repo.deleteSetting(param));
}