

import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/repositories/divisi_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class CreateDivisiUseCase extends BaseUseCase<RequestStatus, Divisi, DivisiRepository> {
  final DivisiRepository repository;

  CreateDivisiUseCase(this.repository) : super(repository, (repo, param) => repo.createDivisi(param));
}