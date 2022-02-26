
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/repository/nhb_repo.dart';

class GetNHBList {
  final NHBRepository repository;

  GetNHBList(this.repository);

  Future<Either<Failure, List<NHB>>> execute(String santriNis) {
    return repository.getNHBList(santriNis);
  }
}