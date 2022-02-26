
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

abstract class SantriRepository {
  Future<Either<Failure, List<Santri>>> getSantriList();
  Future<Either<Failure, Santri>> getSantri(String nis);
  Future<Either<Failure, String>> createSantri(Santri santri);
  Future<Either<Failure, String>> updateSantri(Santri newSantri);
  Future<Either<Failure, String>> deleteSantri(String santriNis);
}