
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/repository/nk_repo.dart';

class DeleteNK {
  final NKRepository repository;

  DeleteNK(this.repository);

  Future<Either<Failure, String>> execute(int id) {
    return repository.deleteNK(id);
  }
}