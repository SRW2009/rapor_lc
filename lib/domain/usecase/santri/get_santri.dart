
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repository/santri_repo.dart';

class GetSantri {
  final SantriRepository repository;

  GetSantri(this.repository);

  Future<Either<Failure, Santri>> execute(String nis) {
    return repository.getSantri(nis);
  }
}