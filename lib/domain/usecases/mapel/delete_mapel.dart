
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/repositories/mapel_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class DeleteMataPelajaranUseCase extends BaseUseCase<RequestStatus, List<String>, MataPelajaranRepository> {
  final MataPelajaranRepository repository;

  DeleteMataPelajaranUseCase(this.repository) : super(repository, (repo, param) => repo.deleteMataPelajaran(param));
}