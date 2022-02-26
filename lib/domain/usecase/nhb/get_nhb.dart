
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/repository/nhb_repo.dart';

class GetNHB {
  final NHBRepository repository;

  GetNHB(this.repository);

  Future<Either<Failure, NHB>> execute(int id) {
    return repository.getNHB(id);
  }
}