
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/mapel_repo.dart';

class UpdateMataPelajaranUseCase extends BaseUseCase<RequestStatus, MataPelajaran, MataPelajaranRepository> {
  MataPelajaranRepository repository;

  UpdateMataPelajaranUseCase(this.repository) : super(repository, (repo, param) => repo.updateMataPelajaran(param));
}