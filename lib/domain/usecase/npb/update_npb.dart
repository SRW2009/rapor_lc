
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/repository/npb_repo.dart';

class UpdateNPB {
  final NPBRepository repository;

  UpdateNPB(this.repository);

  Future<Either<Failure, String>> execute(NPB npb) {
    return repository.updateNPB(npb);
  }
}