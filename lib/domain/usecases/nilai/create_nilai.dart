
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/repositories/nilai_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class CreateNilaiUseCase extends BaseUseCase<RequestStatus, Nilai, NilaiRepository> {
  NilaiRepository repository;

  CreateNilaiUseCase(this.repository) : super(repository, (repo, param) => repo.createNilai(param));
}