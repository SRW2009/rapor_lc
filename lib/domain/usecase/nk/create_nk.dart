
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/repository/nk_repo.dart';

class CreateNK {
  final NKRepository repository;

  CreateNK(this.repository);

  Future<Either<Failure, String>> execute(NK nk) {
    return repository.createNK(nk);
  }
}