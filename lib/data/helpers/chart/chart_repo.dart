/*

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rapor_lc/domain/entities/nhb_semester.dart';

class ChartRepository {
  final colorsCollection = [
    Colors.blue, Colors.orange, Colors.grey, Colors.yellow,
    Colors.green,
  ];

  static final ChartRepository _instance = ChartRepository._internal();
  ChartRepository._internal();
  factory ChartRepository() => _instance;

  Widget _nhbLayout(Map<String, double> data) {
    final chart = SizedBox.square(
      dimension: 230.0,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 0,
          sections: [
            for (int i = 0; i < data.length; i++)
              PieChartSectionData(
                title: data.keys.elementAt(i),
                value: data.values.elementAt(i),
                color: colorsCollection[i],
                radius: 110.0,
                showTitle: false,
              ),
          ],
        ),
      ),
    );
    final legends = [
      for (int i = 0; i < data.length; i++)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: colorsCollection[i],
                width: 13.0,
                height: 13.0,
              ),
              SizedBox(width: 8.0),
              Text(data.keys.elementAt(i)),
            ],
          ),
        ),
    ];
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: chart,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: legends,
                ),
              ),
            ],
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: chart,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: legends,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget nhbChart(List<NHBSemester> list) {
    var data = <String, double>{};
    for (var o in list) {
      var key = o.pelajaran.divisi.name;
      if (key == null) continue;
      if (data.containsKey(key)) {
        final double = data[key]!;
        data[key] = double+o.akumulasi.toDouble();
        continue;
      }
      data[key] = o.akumulasi.toDouble();
    }
    return _nhbLayout(data);
  }
}
*/