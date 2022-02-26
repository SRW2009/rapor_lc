
import 'package:dartz/dartz.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/nk.dart';

abstract class NKRepository {
  Future<Either<Failure, List<NK>>> getNKList(String santriNis);
  Future<Either<Failure, NK>> getNK(int id);
  Future<Either<Failure, String>> createNK(NK nk);
  Future<Either<Failure, String>> updateNK(NK newNK);
  Future<Either<Failure, String>> deleteNK(int id);
  Future<Either<Failure, LineChartData>> getNKChartData(String santriNis);
}