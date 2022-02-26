
import 'package:dartz/dartz.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';

abstract class NPBRepository {
  Future<Either<Failure, List<NPB>>> getNPBList(String santriNis);
  Future<Either<Failure, NPB>> getNPB(int id);
  Future<Either<Failure, String>> createNPB(NPB npb);
  Future<Either<Failure, String>> updateNPB(NPB newNPB);
  Future<Either<Failure, String>> deleteNPB(int id);
  Future<Either<Failure, BarChartData>> getNPBChartData(String santriNis);
}