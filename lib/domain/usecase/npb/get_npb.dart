
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/repository/npb_repo.dart';

class GetNPB {
  final NPBRepository repository;

  GetNPB(this.repository);

  Future<Either<Failure, NPB>> execute(int id) {
    return repository.getNPB(id);
  }
}