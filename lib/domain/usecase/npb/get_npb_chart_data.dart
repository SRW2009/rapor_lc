
import 'package:dartz/dartz.dart';
import 'package:fl_chart/src/chart/bar_chart/bar_chart_data.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/repository/npb_repo.dart';

class GetNPBChartData {
  final NPBRepository repository;

  GetNPBChartData(this.repository);

  Future<Either<Failure, BarChartData>> execute(String santriNis) {
    return repository.getNPBChartData(santriNis);
  }
}