
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

final _values = <num>[6, 3, 1, 1];
final _total = _countTotal();

num _countTotal() {
  num t = 0;
  _values.forEach((element) => t+=element);
  return t;
}

final _persentages = _values.map((e) => (e/_total*100).round()).toList();

final datasets = <PieDataSet>[
  PieDataSet(
    value: _values[0],
    color: PdfColors.blue,
    legend: 'Tahfizh\n${_persentages[0]}%',
    legendPosition: PieLegendPosition.none,
  ),
  PieDataSet(
    value: _values[1],
    color: PdfColors.orange,
    legend: 'IT\n${_persentages[1]}%',
    legendPosition: PieLegendPosition.none,
  ),
  PieDataSet(
    value: _values[2],
    color: PdfColors.grey,
    legend: 'Bahasa\n${_persentages[2]}%',
    legendPosition: PieLegendPosition.none,
  ),
  PieDataSet(
    value: _values[3],
    color: PdfColors.yellow,
    legend: 'MPP\n${_persentages[3]}%',
    legendPosition: PieLegendPosition.none,
  ),
];