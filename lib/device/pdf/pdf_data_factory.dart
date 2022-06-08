
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/common/item_frequency.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npb.dart';

int _presensiToInt(String presensi) => int.tryParse(presensi.replaceAll('%', '')) ?? 0;

const _Colors = [
  PdfColors.blue, PdfColors.orange, PdfColors.grey, PdfColors.yellow, PdfColors.green,
  PdfColors.red, PdfColors.black, PdfColors.teal, PdfColors.brown, PdfColors.purple,
];

class _NPBData {
  final List<MataPelajaran> mapels;
  final List<BarDataSet> datasets;

  _NPBData(this.mapels, this.datasets);
}

class ChartDatasetsFactory {
  static List<PieDataSet> buildNHBDatasets(List<Nilai> nilaiList, int semester) {
    var processedNilaiList = <Nilai>[];

    // process nilai list to match parameters
    for (var nilai in nilaiList) {
      // only take nilai that match requested semester
      if (semester != nilai.BaS.semester) continue;

      // add processed nilai to data
      processedNilaiList.add(nilai);
    }

    // process value of each divisi
    Map<String, int> divValueMap = {};
    processedNilaiList.forEach((nilai) {
      for (var e in nilai.nhb) {
        // update divisi value
        divValueMap.update(
          e.pelajaran.divisi!.name,
              (value) => ((e.akumulasi+value)/2).round(),
          ifAbsent: () => e.akumulasi,
        );
      }
    });

    // sum every value for each divisi
    final totalValue = divValueMap.values
        .fold<int>(0, (previousValue, element) => previousValue+element);

    // counter for color variation in chart
    var colorI = 0;

    // process datasets
    final datasets = divValueMap.keys
        .map<PieDataSet>((e) => PieDataSet(
      value: divValueMap[e] ?? 0,
      color: _Colors[colorI++],
      legend: '$e\n${((divValueMap[e] ?? 0)/totalValue*100).round()}%',
      legendPosition: PieLegendPosition.none,
    ),).toList();
    return datasets;
  }

  static _NPBData buildNPBDatasets(List<Nilai> nilaiList, int semester, bool isIT) {
    var divisiList = <String>[];
    var mapelList = <MataPelajaran>[];
    var processedNilaiList = <Nilai>[];

    // process nilai list to match parameters
    for (var nilai in nilaiList) {

      var npbList = <NPB>[];
      for (var e in nilai.npb) {
        // separate npb by IT division or not
        if (isIT && e.pelajaran.divisi!.name != 'IT') continue;
        if (!isIT && e.pelajaran.divisi!.name == 'IT') continue;

        npbList.add(e);

        // collect every mapel and divisi that appeared
        if (!mapelList.contains(e.pelajaran)) {

          mapelList.add(e.pelajaran);
          if (!divisiList.contains(e.pelajaran.divisi!.name)) divisiList.add(e.pelajaran.divisi!.name);
        }
      }

      // add processed nilai to data
      processedNilaiList.add(nilai.clone()..npb=npbList);
    }

    // ( Bug Workaround ) if mapelList only contain 1 or 2,
    // add dummy data so their bar in chart will go to center
    bool createDummy = false;
    if (mapelList.length <= 2) {
      createDummy = true;

      final divisi = mapelList.first.divisi!;
      mapelList.insert(0, MataPelajaran(-1, ':::', divisi: divisi));
      mapelList.add(MataPelajaran(-2, '::::', divisi: divisi));
    }

    // sort the list from older to newer, so the recent value will replace the old one
    processedNilaiList.sort((a, b) => a.BaS.compareTo(b.BaS));

    // process mapel and always take the recent value
    Map<String, int> mapelValueMap = {};
    processedNilaiList.forEach((nilai) {
      for (var e in nilai.npb) {
        // if this mapel is not listed in mapel list, skip
        if (!mapelList.contains(e.pelajaran)) continue;

        // update mapel presensi value
        mapelValueMap.update(
          e.pelajaran.name,
          (value) {
            if (nilai.BaS.semester <= semester
                && _presensiToInt(e.presensi) > value)
              return _presensiToInt(e.presensi);
            return value;
          },
          ifAbsent: () {
            if (nilai.BaS.semester <= semester)
              return _presensiToInt(e.presensi);
            return 0;
          }
        );
      }
    });

    // create dummy in mapelValueMap
    if (createDummy) {
      mapelValueMap[':::'] = 0;
      mapelValueMap['::::'] = 0;
    }


    // counter for color variation in chart
    var colorI = 0;

    // process datasets
    final datasets = divisiList
        .map<BarDataSet>((e) => BarDataSet(
      color: _Colors[colorI++],
      axis: Axis.vertical,
      legend: e,
      width: 8,
      data: [
        for (var i=0;i<mapelValueMap.entries.length;i++)
          LineChartValue(
            (mapelList.elementAt(i).divisi!.name == e)
                ? mapelValueMap[mapelList.elementAt(i).name]!.toDouble()
                : 0.0,
            i.toDouble(),
          ),
      ],
    )).toList();
    return _NPBData(mapelList, datasets);
  }

  static List<LineDataSet> buildNKDatasets(List<Nilai> nilaiList, int semester) {
    // process value of each variable
    Map<String, List<int?>> varValuesMap = {};
    for (var nilai in nilaiList) {
      // only take nilai that match requested semester
      if (semester != nilai.BaS.semester) continue;

      // determine which month this nilai nk for
      var monthIndex = nilai.BaS.semester.isOdd ? nilai.BaS.bulan-1 : nilai.BaS.bulan-7;

      // update every variable's value for this month
      for (var o in nilai.nk) {
        varValuesMap.update(
          o.nama_variabel,
              (list) {
            var value = (list[monthIndex] == null)
                ? o.akumulatif
                : ((list[monthIndex]! + o.akumulatif)/2).round();
            return list..replaceRange(monthIndex, monthIndex+1, [value]);
          },
          ifAbsent: () => [null,null,null,null,null,null]
            ..replaceRange(monthIndex, monthIndex+1, [o.akumulatif]),
        );
      }
    }

    // counter for color variation in chart
    var colorI = 0;

    // process datasets
    final datasets = varValuesMap.entries
      .map<LineDataSet>((e) => LineDataSet(
      legend: e.key,
      color: _Colors[colorI++],
      lineWidth: 3.2,
      pointSize: 4.0,
      data: List<LineChartValue>.generate(6, (index) =>
          LineChartValue(index.toDouble(), e.value[index]?.toDouble() ?? 0.0),
    ))).toList();
    return datasets;
  }
}

class TableContentsFactory {
  static  Map<int, NHB> buildNHBContents(List<Nilai> nilaiList, int semester) {
    // key of this map is mapel id
    Map<int, NHB> nhbValueMap = {};

    // process nhb to match parameters
    for (var nilai in nilaiList) {
      // only take nilai that match requested semester
      if (nilai.BaS.semester != semester) continue;

      for (var o in nilai.nhb) {
        // update value
        nhbValueMap.update(
          o.pelajaran.id,
          (v) {
            // calculate average of both value
            var harian = NilaiCalculation.accumulate([v.nilai_harian, o.nilai_harian]);
            var bulanan = NilaiCalculation.accumulate([v.nilai_bulanan, o.nilai_bulanan]);
            var projek = NilaiCalculation.accumulate([v.nilai_projek, o.nilai_projek]);
            var akhir = NilaiCalculation.accumulate([v.nilai_akhir, o.nilai_akhir]);
            var acc = NilaiCalculation.accumulate([v.akumulasi, o.akumulasi]);
            var pred = NilaiCalculation.toPredicate(acc);
            return NHB(o.no, o.pelajaran, harian.round(), bulanan.round(), projek.round(), akhir.round(), acc.round(), pred);
          },
          ifAbsent: () => o,
        );
      }
    }

    return nhbValueMap;
  }

  static Map<String, NK> buildNKContents(List<Nilai> nilaiList, int semester) {
    // key of this map is mapel id
    Map<String, NK> nkValueMap = {};

    for (var nilai in nilaiList) {
      // only take nilai that match requested semester
      if (nilai.BaS.semester != semester) continue;

      for (var o in nilai.nk) {
        nkValueMap.update(
          o.nama_variabel,
          (v) {
            // calculate average of both value
            var asrama = NilaiCalculation.accumulate([v.nilai_asrama, o.nilai_asrama]).toInt();
            var kelas = NilaiCalculation.accumulate([v.nilai_kelas, o.nilai_kelas]).toInt();
            var mesjid = NilaiCalculation.accumulate([v.nilai_mesjid, o.nilai_mesjid]).toInt();
            var acc = NilaiCalculation.accumulate([v.akumulatif, o.akumulatif]);
            var pred = NilaiCalculation.toPredicate(acc);
            return NK(v.no, v.nama_variabel, mesjid, kelas, asrama, acc.toInt(), pred);
          },
          ifAbsent: () => o,
        );
      }
    }

    return nkValueMap;
  }

  static List<ItemFrequency<NPB>> buildNPBContents(List<Nilai> nilaiList, int semester, bool isIT) {
    Map<String, List<int>> mapelAndSemesterAppeared = {};
    List<ItemFrequency<NPB>> processedNPB = [];

    // process npb to match parameters
    for (var nilai in nilaiList) {
      // only take nilai where semester is not greater than requested semester
      if (nilai.BaS.semester > semester) continue;

      for (var o in nilai.npb) {
        // separate npb by IT division or not
        if (isIT && o.pelajaran.divisi!.name != 'IT') continue;
        if (!isIT && o.pelajaran.divisi!.name == 'IT') continue;

        // if mapel already listed here, check its semester list
        if (mapelAndSemesterAppeared.containsKey(o.pelajaran.name)) {
          var npbRef = processedNPB.firstWhere((e) => e.item.pelajaran.name==o.pelajaran.name);

          // if presensi is greater than current presensi, replace presensi with the greater one
          if (_presensiToInt(o.presensi) > _presensiToInt(npbRef.item.presensi)) {
            final newNPB = NPB(npbRef.item.no, npbRef.item.pelajaran, o.presensi);
            npbRef.item = newNPB;
          }

          // if semester is not listed, add item to data
          if (!mapelAndSemesterAppeared[o.pelajaran.name]!.contains(nilai.BaS.semester)) {
            mapelAndSemesterAppeared[o.pelajaran.name]!.add(nilai.BaS.semester);
            npbRef.n+=1;
          }
        }
        // otherwise add item to data
        else {
          mapelAndSemesterAppeared[o.pelajaran.name] = [nilai.BaS.semester];
          processedNPB.add(ItemFrequency(o, n: 1));
        }
      }
    }

    return processedNPB;
  }
}