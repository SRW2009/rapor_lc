
import 'package:fl_chart/fl_chart.dart';

class ChartRepository {

  static final ChartRepository _instance = ChartRepository._internal();
  ChartRepository._internal();
  factory ChartRepository() => _instance;

  
}