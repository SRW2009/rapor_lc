
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/repositories/nilai_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetNilaiListUseCase extends BaseUseCase<List<Nilai>, void, NilaiRepository> {
  NilaiRepository repository;

  GetNilaiListUseCase(this.repository) : super(repository, (repo, param) => repo.getNilaiList());
}