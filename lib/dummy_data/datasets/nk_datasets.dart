
import 'dart:math';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final Random r = Random();
final datasets = <pw.LineDataSet>[
  pw.LineDataSet(
    legend: 'Inisiatif',
    color: PdfColors.blue,
    lineWidth: 3.2,
    pointSize: 4.0,
    data: List<pw.LineChartValue>.generate(6, (index) =>
        pw.LineChartValue(index.toDouble(), r.nextInt(70)+30)),
  ),
  pw.LineDataSet(
    legend: 'Kontrol Diri',
    color: PdfColors.orange,
    lineWidth: 3.2,
    pointSize: 4.0,
    data: List<pw.LineChartValue>.generate(6, (index) =>
        pw.LineChartValue(index.toDouble(), r.nextInt(70)+30)),
  ),
  pw.LineDataSet(
    legend: 'Kontrol Potensi',
    color: PdfColors.grey,
    lineWidth: 3.2,
    pointSize: 4.0,
    data: List<pw.LineChartValue>.generate(6, (index) =>
        pw.LineChartValue(index.toDouble(), r.nextInt(70)+30)),
  ),
  pw.LineDataSet(
    legend: 'Menghargai Karya',
    color: PdfColors.amber,
    lineWidth: 3.2,
    pointSize: 4.0,
    data: List<pw.LineChartValue>.generate(6, (index) =>
        pw.LineChartValue(index.toDouble(), r.nextInt(70)+30)),
  ),
];