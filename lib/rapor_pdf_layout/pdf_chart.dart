
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class MyPDFChart {
  static Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        title,
        style: TextStyle(
          color: PdfColors.grey700,
          font: Font.times(),
          fontSize: 18.0,
        ),
      ),
    );
  }

  static Chart buildNKLineChart(List<LineDataSet> datasets) {
    final _months = ['Januari', 'Februari', 'Maret', 'April', 'Mei',
      'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];

    return Chart(
      title: _buildTitle('Analisa Aspek Kemadirian Santri'),
      bottom: ChartLegend(
        position: Alignment.center,
        direction: Axis.horizontal,
        textStyle: TextStyle(
          fontSize: 12.0,
          font: Font.times(),
        ),
      ),
      grid: CartesianGrid(
        xAxis: FixedAxis.fromStrings(
          List.generate(6, (i) => _months[i]),
          marginStart: 30,
          marginEnd: 30,
          ticks: true,
        ),
        yAxis: FixedAxis(
          <num>[0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
          divisions: true,
        ),
      ),
      datasets: datasets,
    );
  }

  static Chart buildNHBPieChart(List<PieDataSet> datasets) {
    return Chart(
      title: _buildTitle('Analisa Dominasi Santri'),
      grid: PieGrid(),
      right: ChartLegend(
        direction: Axis.vertical,
        position: Alignment.centerRight,
        padding: const EdgeInsets.only(left: 16.0),
        textStyle: TextStyle(
          fontSize: 12.0,
          font: Font.times(),
        ),
      ),
      datasets: datasets,
    );
  }

  static Chart buildNPBBarChart(List<String> plpsName, List<BarDataSet> datasets) {
    return Chart(
      title: _buildTitle('Analisa Proses Belajar Santri'),
      bottom: ChartLegend(
        position: Alignment.center,
        direction: Axis.horizontal,
        textStyle: TextStyle(
          fontSize: 12.0,
          font: Font.times(),
        ),
      ),
      grid: CartesianGrid(
        xAxis: FixedAxis.fromStrings(
          plpsName,
          marginStart: 20,
          marginEnd: 20,
          ticks: true,
          angle: 1,
          textStyle: const TextStyle(
            fontSize: 9.0,
          ),
        ),
        yAxis: FixedAxis(
          <num>[0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
          divisions: true,
        ),
      ),
      datasets: datasets,
    );
  }
}