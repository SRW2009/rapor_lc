
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/rapor_pdf_layout/pdf_chart_datasets_factory.dart';

class MyPDFChart {
  static Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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

  static Chart buildNKLineChart(List<Nilai> nilaiList, int semester) {
    final _months = ['Januari', 'Februari', 'Maret', 'April', 'Mei',
      'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];

    var datasets = DatasetsFactory.buildNKDatasets(nilaiList, semester);
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
          List.generate(6, (i) => _months[semester.isOdd ? i+6 : i]),
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

  static Chart buildNHBPieChart(List<Nilai> nilaiList, int semester) {
    var datasets = DatasetsFactory.buildNHBDatasets(nilaiList, semester);
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

  static Chart buildNPBBarChart(List<Nilai> nilaiList, int semester, bool isIT) {
    var data = DatasetsFactory.buildNPBDatasets(nilaiList, semester, isIT);
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
        xAxis: FixedAxis(
          <num>[0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
          divisions: true,
        ),
        yAxis: FixedAxis.fromStrings(
          data.mapels.map<String>((e) => e.name).toList(),
          marginStart: 20,
          marginEnd: 20,
          ticks: true,
          angle: 0,
          textStyle: const TextStyle(
            fontSize: 9.0,
          ),
        ),
      ),
      datasets: data.datasets,
    );
  }
}