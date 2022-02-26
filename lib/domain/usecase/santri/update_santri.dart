
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repository/santri_repo.dart';

class UpdateSantri {
  final SantriRepository repository;

  UpdateSantri(this.repository);

  Future<Either<Failure, String>> execute(Santri santri) {
    return repository.updateSantri(santri);
  }
}