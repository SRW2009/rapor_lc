
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/repository/npb_repo.dart';

class GetNPBList {
  final NPBRepository repository;

  GetNPBList(this.repository);

  Future<Either<Failure, List<NPB>>> execute(String santriNis) {
    return repository.getNPBList(santriNis);
  }
}