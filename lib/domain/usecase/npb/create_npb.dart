
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/repository/npb_repo.dart';

class CreateNPB {
  final NPBRepository repository;

  CreateNPB(this.repository);

  Future<Either<Failure, String>> execute(NPB npb) {
    return repository.createNPB(npb);
  }
}