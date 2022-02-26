
import 'package:dartz/dartz.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/repository/nhb_repo.dart';

class GetNHBChartData {
  final NHBRepository repository;

  GetNHBChartData(this.repository);

  Future<Either<Failure, PieChartData>> execute(int id) {
    return repository.getNHBChartData(id);
  }
}