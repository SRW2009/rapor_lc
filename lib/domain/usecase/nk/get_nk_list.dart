
import 'package:dartz/dartz.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/repository/nk_repo.dart';

class GetNKList {
  final NKRepository repository;

  GetNKList(this.repository);

  Future<Either<Failure, List<NK>>> execute(String santriNis) {
    return repository.getNKList(santriNis);
  }
}