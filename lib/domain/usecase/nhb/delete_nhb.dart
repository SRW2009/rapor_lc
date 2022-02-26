
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/repository/nhb_repo.dart';

class DeleteNHB {
  final NHBRepository repository;

  DeleteNHB(this.repository);

  Future<Either<Failure, String>> execute(int id) {
    return repository.deleteNHB(id);
  }
}