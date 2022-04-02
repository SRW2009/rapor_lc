
import 'dart:math';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/dummy_data/dummies.dart';

final plpsName = mapelList.map<String>((e) => e.name).toList();

final Random random = Random();
List<BarDataSet> getDatasets({isObservation=false}) => <BarDataSet>[
  BarDataSet(
    color: PdfColors.blue,
    legend: 'Tahfiz',
    width: 8,
    data: List<LineChartValue>.generate(mapelList.length, (i) {
      double y = 0;
      if (mapelList[i].divisi?.name == 'Tahfiz') {
        y = random.nextInt(70).toDouble()+30;
      }
      return LineChartValue(i.toDouble(), y);
    })..addAll(List<LineChartValue>.generate(mapelList.length, (i) {
      double y = 0;
      if (!isObservation && mapelList[i].divisi?.name == 'Tahfiz') {
        y = random.nextInt(70).toDouble()+30;
      }
      return LineChartValue((i+mapelList.length).toDouble(), y);
    })),
  ),
  BarDataSet(
    color: PdfColors.orange,
    legend: 'IT',
    width: 8,
    data: List<LineChartValue>.generate(mapelList.length, (i) {
      double y = 0;
      if (mapelList[i].divisi?.name == 'IT') {
        y = random.nextInt(70).toDouble()+30;
      }
      return LineChartValue(i.toDouble(), y);
    })..addAll(List<LineChartValue>.generate(mapelList.length, (i) {
      double y = 0;
      if (!isObservation && mapelList[i].divisi?.name == 'IT') {
        y = random.nextInt(70).toDouble()+30;
      }
      return LineChartValue((i+mapelList.length).toDouble(), y);
    })),
  ),
  BarDataSet(
    color: PdfColors.grey,
    legend: 'Bahasa',
    width: 8,
    data: List<LineChartValue>.generate(mapelList.length, (i) {
      double y = 0;
      if (mapelList[i].divisi?.name == 'Bahasa') {
        y = random.nextInt(70).toDouble()+30;
      }
      return LineChartValue(i.toDouble(), y);
    })..addAll(List<LineChartValue>.generate(mapelList.length, (i) {
      double y = 0;
      if (!isObservation && mapelList[i].divisi?.name == 'Bahasa') {
        y = random.nextInt(70).toDouble()+30;
      }
      return LineChartValue((i+mapelList.length).toDouble(), y);
    })),
  ),
  BarDataSet(
    color: PdfColors.yellow,
    legend: 'MPP',
    width: 8,
    data: List<LineChartValue>.generate(mapelList.length, (i) {
      double y = 0;
      if (mapelList[i].divisi?.name == 'MPP') {
        y = random.nextInt(70).toDouble()+30;
      }
      return LineChartValue(i.toDouble(), y);
    })..addAll(List<LineChartValue>.generate(mapelList.length, (i) {
      double y = 0;
      if (!isObservation && mapelList[i].divisi?.name == 'MPP') {
        y = random.nextInt(70).toDouble()+30;
      }
      return LineChartValue((i+mapelList.length).toDouble(), y);
    })),
  ),
];