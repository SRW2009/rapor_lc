
import 'dart:math';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rapor_lc/dummy_data/mata_pelajaran.dart';

final plpsName = pelajaranList.map<String>((e) => e.namaMapel).toList();
final plpsName_observation = pelajaranList_observation.map<String>((e) => e.namaMapel).toList();

final Random random = Random();
List<pw.BarDataSet> getDatasets({isObservation=false}) => <pw.BarDataSet>[
  pw.BarDataSet(
    color: PdfColors.blue,
    legend: 'Tahfiz',
    width: 8,
    data: List<pw.LineChartValue>.generate(pelajaranList_observation.length, (i) {
      double y = 0;
      if (pelajaranList_observation[i].divisi.nama == 'Tahfiz') {
        y = random.nextInt(70).toDouble()+30;
      }
      return pw.LineChartValue(i.toDouble(), y);
    })..addAll(List<pw.LineChartValue>.generate(pelajaranList.length, (i) {
      double y = 0;
      if (!isObservation && pelajaranList[i].divisi.nama == 'Tahfiz') {
        y = random.nextInt(70).toDouble()+30;
      }
      return pw.LineChartValue((i+pelajaranList_observation.length).toDouble(), y);
    })),
  ),
  pw.BarDataSet(
    color: PdfColors.orange,
    legend: 'IT',
    width: 8,
    data: List<pw.LineChartValue>.generate(pelajaranList_observation.length, (i) {
      double y = 0;
      if (pelajaranList_observation[i].divisi.nama == 'IT') {
        y = random.nextInt(70).toDouble()+30;
      }
      return pw.LineChartValue(i.toDouble(), y);
    })..addAll(List<pw.LineChartValue>.generate(pelajaranList.length, (i) {
      double y = 0;
      if (!isObservation && pelajaranList[i].divisi.nama == 'IT') {
        y = random.nextInt(70).toDouble()+30;
      }
      return pw.LineChartValue((i+pelajaranList_observation.length).toDouble(), y);
    })),
  ),
  pw.BarDataSet(
    color: PdfColors.grey,
    legend: 'Bahasa',
    width: 8,
    data: List<pw.LineChartValue>.generate(pelajaranList_observation.length, (i) {
      double y = 0;
      if (pelajaranList_observation[i].divisi.nama == 'Bahasa') {
        y = random.nextInt(70).toDouble()+30;
      }
      return pw.LineChartValue(i.toDouble(), y);
    })..addAll(List<pw.LineChartValue>.generate(pelajaranList.length, (i) {
      double y = 0;
      if (!isObservation && pelajaranList[i].divisi.nama == 'Bahasa') {
        y = random.nextInt(70).toDouble()+30;
      }
      return pw.LineChartValue((i+pelajaranList_observation.length).toDouble(), y);
    })),
  ),
  pw.BarDataSet(
    color: PdfColors.yellow,
    legend: 'MPP',
    width: 8,
    data: List<pw.LineChartValue>.generate(pelajaranList_observation.length, (i) {
      double y = 0;
      if (pelajaranList_observation[i].divisi.nama == 'MPP') {
        y = random.nextInt(70).toDouble()+30;
      }
      return pw.LineChartValue(i.toDouble(), y);
    })..addAll(List<pw.LineChartValue>.generate(pelajaranList.length, (i) {
      double y = 0;
      if (!isObservation && pelajaranList[i].divisi.nama == 'MPP') {
        y = random.nextInt(70).toDouble()+30;
      }
      return pw.LineChartValue((i+pelajaranList_observation.length).toDouble(), y);
    })),
  ),
];