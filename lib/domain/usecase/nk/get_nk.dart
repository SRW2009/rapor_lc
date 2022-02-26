
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/repository/nk_repo.dart';

class GetNK {
  final NKRepository repository;

  GetNK(this.repository);

  Future<Either<Failure, NK>> execute(int id) {
    return repository.getNK(id);
  }
}