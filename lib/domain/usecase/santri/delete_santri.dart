
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repository/santri_repo.dart';

class DeleteSantri {
  final SantriRepository repository;

  DeleteSantri(this.repository);

  Future<Either<Failure, String>> execute(String nis) {
    return repository.deleteSantri(nis);
  }
}