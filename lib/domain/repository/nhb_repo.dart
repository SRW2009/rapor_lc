
import 'package:dartz/dartz.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';

abstract class NHBRepository {
  Future<Either<Failure, List<NHB>>> getNHBList(String santriNis);
  Future<Either<Failure, NHB>> getNHB(int id);
  Future<Either<Failure, String>> createNHB(NHB nhb);
  Future<Either<Failure, String>> updateNHB(NHB newNHB);
  Future<Either<Failure, String>> deleteNHB(int id);
  Future<Either<Failure, PieChartData>> getNHBChartData(int id);
}