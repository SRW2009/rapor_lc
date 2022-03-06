

import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/repositories/mapel_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class CreateMataPelajaranUseCase extends BaseUseCase<RequestStatus, MataPelajaran, MataPelajaranRepository> {
  final MataPelajaranRepository repository;

  CreateMataPelajaranUseCase(this.repository) : super(repository, (repo, param) => repo.createMataPelajaran(param));
}