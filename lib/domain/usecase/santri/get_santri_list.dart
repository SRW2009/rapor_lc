
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repository/santri_repo.dart';

class GetSantriList {
  final SantriRepository repository;

  GetSantriList(this.repository);

  Future<Either<Failure, List<Santri>>> execute() {
    return repository.getSantriList();
  }
}