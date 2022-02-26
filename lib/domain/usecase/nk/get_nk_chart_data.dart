
import 'package:dartz/dartz.dart';
import 'package:fl_chart/src/chart/line_chart/line_chart_data.dart';
import 'package:rapor_lc/common/failure.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/repository/nk_repo.dart';

class GetNKChartData {
  final NKRepository repository;

  GetNKChartData(this.repository);

  Future<Either<Failure, LineChartData>> execute(String santriNis) {
    return repository.getNKChartData(santriNis);
  }
}