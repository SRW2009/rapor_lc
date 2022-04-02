
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/repositories/nilai_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class UpdateNilaiUseCase extends BaseUseCase<RequestStatus, Nilai, NilaiRepository> {
  NilaiRepository repository;

  UpdateNilaiUseCase(this.repository) : super(repository, (repo, param) => repo.updateNilai(param));
}