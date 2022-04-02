
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/repositories/nilai_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class DeleteNilaiUseCase extends BaseUseCase<RequestStatus, List<String>, NilaiRepository> {
  NilaiRepository repository;

  DeleteNilaiUseCase(this.repository) : super(repository, (repo, param) => repo.deleteNilai(param));
}