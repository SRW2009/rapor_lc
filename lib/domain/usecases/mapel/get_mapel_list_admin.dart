
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/repositories/mapel_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetMataPelajaranListAdminUseCase extends BaseUseCase<List<MataPelajaran>, void, MataPelajaranRepository> {
  final MataPelajaranRepository repository;

  GetMataPelajaranListAdminUseCase(this.repository) : super(repository, (repo, param) => repo.getMataPelajaranListAdmin());
}