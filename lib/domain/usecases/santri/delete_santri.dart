
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/repositories/santri_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class DeleteSantriUseCase extends BaseUseCase<RequestStatus, List<String>, SantriRepository> {
  final SantriRepository repository;

  DeleteSantriUseCase(this.repository) : super(repository, (repo, param) => repo.deleteSantri(param));
}