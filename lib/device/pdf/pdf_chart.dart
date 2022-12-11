
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/device/pdf/pdf_data_factory.dart';
import 'package:rapor_lc/device/pdf/pdf_object.dart';
import 'package:rapor_lc/device/pdf/pdf_widget.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';

class MyPDFChart {
  static Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: headerTextStyle(),
      ),
    );
  }

  static Chart buildNKLineChart(NKDatasets datasets, Timeline timeline) {
    final _months = ['Januari', 'Februari', 'Maret', 'April', 'Mei',
      'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];

    return Chart(
      title: _buildTitle('Analisa Aspek Kemandirian Santri'),
      bottom: ChartLegend(
        padding: EdgeInsets.all(5).copyWith(top: 10),
        position: Alignment.center,
        direction: Axis.horizontal,
        textStyle: bodyTextStyle(),
      ),
      grid: CartesianGrid(
        xAxis: FixedAxis.fromStrings(
          List.generate(6, (i) => _months[timeline.semester.isOdd ? i+6 : i]),
          marginStart: 30,
          marginEnd: 30,
          ticks: true,
        ),
        yAxis: FixedAxis(
          <num>[0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
          divisions: true,
        ),
      ),
      datasets: datasets.datasets,
    );
  }

  static Chart buildNHBBarChart(NHBDatasets datasets) {
    return Chart(
      title: _buildTitle('Grafik NHB'),
      bottom: ChartLegend(
        padding: EdgeInsets.all(5).copyWith(top: 10),
        position: Alignment.center,
        direction: Axis.horizontal,
        textStyle: bodyTextStyle(),
      ),
      grid: CartesianGrid(
        xAxis: FixedAxis.fromStrings(
          (datasets.mapels).map<String>((e) {
            // if dummy exist
            if (e.name == ':::') return '';
            if (e.name == '::::') return '';

            return e.abbreviation ?? e.name;
          }).toList(),
          marginStart: 12,
          marginEnd: 12,
          ticks: true,
          angle: 0,
          textStyle: bodyTextStyle(size: 10),
        ),
        yAxis: FixedAxis(
          <num>[0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
          divisions: true,
          textStyle: bodyTextStyle(size: 12),
        ),
      ),
      datasets: datasets.datasets,
    );
  }

  static Chart buildNPBBarChart(List<Nilai> nilaiList, int semester, bool isIT) {
    var data = ChartDatasetsFactory.buildNPBDatasets(nilaiList, semester, isIT);
    return Chart(
      title: _buildTitle('Analisa Proses Belajar Santri'),
      bottom: ChartLegend(
        padding: EdgeInsets.all(5).copyWith(top: 10),
        position: Alignment.center,
        direction: Axis.horizontal,
        textStyle: bodyTextStyle(),
      ),
      grid: CartesianGrid(
        xAxis: FixedAxis(
          <num>[0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
          divisions: true,
        ),
        yAxis: FixedAxis.fromStrings(
          data.mapels.map<String>((e) {
            // if dummy exist
            if (e.name == ':::') return '';
            if (e.name == '::::') return '';

            return e.name;
          }).toList(),
          marginStart: 20,
          marginEnd: 20,
          ticks: true,
          angle: 0,
          textStyle: bodyTextStyle(size: 9),
        ),
      ),
      datasets: data.datasets,
    );
  }
}