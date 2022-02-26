
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/repository/nhb_repo.dart';

class CreateNHB {
  final NHBRepository repository;

  CreateNHB(this.repository);

  Future<Either<Failure, String>> execute(NHB nhb) {
    return repository.createNHB(nhb);
  }
}