
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/repository/npb_repo.dart';

class DeleteNPB {
  final NPBRepository repository;

  DeleteNPB(this.repository);

  Future<Either<Failure, String>> execute(int id) {
    return repository.deleteNPB(id);
  }
}