
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/repositories/divisi_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class GetDivisiListUseCase extends BaseUseCase<List<Divisi>, void, DivisiRepository> {
  final DivisiRepository repository;

  GetDivisiListUseCase(this.repository) : super(repository, (repo, param) => repo.getDivisiList());
}