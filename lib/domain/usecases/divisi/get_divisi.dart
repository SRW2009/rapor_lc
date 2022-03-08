
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/divisi_repo.dart';

class GetDivisiUseCase extends BaseUseCase<Divisi, int, DivisiRepository> {
  DivisiRepository repository;

  GetDivisiUseCase(this.repository) : super(repository, (repo, param) => repo.getDivisi(param));
}