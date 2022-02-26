
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repository/santri_repo.dart';

class CreateSantri {
  final SantriRepository repository;

  CreateSantri(this.repository);

  Future<Either<Failure, String>> execute(Santri santri) {
    return repository.createSantri(santri);
  }
}