
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/mapel_repo.dart';

class GetMataPelajaranUseCase extends BaseUseCase<MataPelajaran, int, MataPelajaranRepository> {
  MataPelajaranRepository repository;

  GetMataPelajaranUseCase(this.repository) : super(repository, (repo, param) => repo.getMataPelajaran(param));
}