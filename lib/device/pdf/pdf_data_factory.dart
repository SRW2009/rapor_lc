
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/common/item_frequency.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npb.dart';

const _Colors = [PdfColors.blue, PdfColors.orange, PdfColors.grey, PdfColors.yellow, PdfColors.green];

class _NPBData {
  final List<MataPelajaran> mapels;
  final List<BarDataSet> datasets;

  _NPBData(this.mapels, this.datasets);
}

class ChartDatasetsFactory {
  static int _presensiToInt(String presensi) => int.tryParse(presensi.replaceAll('%', '')) ?? 0;

  static _NPBData buildNPBDatasets(List<Nilai> nilaiList, int semester, bool isIT) {
    var divisiList = <String>[];
    var mapelList = <MataPelajaran>[];
    var processedNilaiList = <Nilai>[];

    // process nilai list to match parameters
    for (var nilai in nilaiList) {
      // if requested semester is even, take every nilai where their semester is less than or equal to requested semester.
      if (semester.isEven && nilai.BaS.semester > semester) continue;
      // if requested semester is odd, take every nilai that match the conditions above, AND every nilai where their semester is equal to requested semester + 1.
      if (semester.isOdd && nilai.BaS.semester > semester+1) continue;

      var npbList = <NPB>[];
      for (var e in nilai.npb) {
        // separate npb by IT division or not
        if (isIT && e.pelajaran.divisi!.name != 'IT') continue;
        if (!isIT && e.pelajaran.divisi!.name == 'IT') continue;

        // add this npb to npb list
        npbList.add(e);

        // collect and process every mapel that appear
        if (!mapelList.contains(e.pelajaran)) {
          /// if semester is odd, take mapel of said semester AND the semester after.
          /// if semester is even, take mapel of said semester AND the semester before.
          if (semester.isOdd
              && (nilai.BaS.semester==semester || nilai.BaS.semester==semester+1)) mapelList.add(e.pelajaran);
          if (semester.isEven
              && (nilai.BaS.semester==semester || nilai.BaS.semester==semester-1)) mapelList.add(e.pelajaran);

          // collect every divisi that appeared
          if (!divisiList.contains(e.pelajaran.divisi?.name)) divisiList.add(e.pelajaran.divisi!.name);
        }
      }

      // add processed nilai to data
      processedNilaiList.add(Nilai.fromJson(nilai.toJson())..npb=npbList);
    }

    // sort the list from older to newer, so the recent value will replace the old one
    processedNilaiList.sort((a, b) => a.BaS.compareTo(b.BaS));

    // process mapel and always take the recent value
    Map<String, int> mapelValueMap = {};
    processedNilaiList.forEach((nilai) {
      bool nilaiSemesterisOdd = nilai.BaS.semester.isOdd;
      for (var e in nilai.npb) {
        // if this mapel is not listed in mapel list, skip
        if (!mapelList.contains(e.pelajaran)) continue;

        // update mapel value
        if (semester.isOdd)
          mapelValueMap[e.pelajaran.name] = nilaiSemesterisOdd ? _presensiToInt(e.presensi) : 0;
        else
          mapelValueMap[e.pelajaran.name] = _presensiToInt(e.presensi);
      }
    });

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
            (mapelList.elementAt(i).divisi!.name == e
                && mapelList.elementAt(i).name==mapelValueMap.keys.elementAt(i))
                ? mapelValueMap.values.elementAt(i).toDouble()
                : 0.0,
            i.toDouble(),
          )
      ],
    )).toList();
    return _NPBData(mapelList, datasets);
  }

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
            // calculate mean of both value
            num harian = NilaiCalculation.accumulate([v.nilai_harian, o.nilai_harian]);
            num bulanan = NilaiCalculation.accumulate([v.nilai_bulanan, o.nilai_bulanan]);
            num projek = o.nilai_projek==-1 ? v.nilai_projek : NilaiCalculation.accumulate([v.nilai_projek, o.nilai_projek]);
            num akhir = o.nilai_akhir==-1 ? v.nilai_akhir : NilaiCalculation.accumulate([v.nilai_akhir, o.nilai_akhir]);

            var acc = NilaiCalculation.accumulate([harian.round(), bulanan.round(), if (projek != -1) projek.round(), if (akhir != -1) akhir.round()]);
            var pred = NilaiCalculation.toPredicate(acc);
            return NHB(o.no, o.pelajaran, harian.round(), bulanan.round(), projek.round(), akhir.round(), acc, pred);
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
            var asrama = NilaiCalculation.accumulate([v.nilai_asrama, o.nilai_asrama]);
            var kelas = NilaiCalculation.accumulate([v.nilai_kelas, o.nilai_kelas]);
            var mesjid = NilaiCalculation.accumulate([v.nilai_mesjid, o.nilai_mesjid]);
            var acc = NilaiCalculation.accumulate([asrama, kelas, mesjid]);
            var pred = NilaiCalculation.toPredicate(acc);
            return NK(v.no, v.nama_variabel, mesjid, kelas, asrama, acc, pred);
          },
          ifAbsent: () => o,
        );
      }
    }

    return nkValueMap;
  }

  static List<ItemFrequency<NPB>> buildNPBContents(List<Nilai> nilaiList, int semester, bool isIT) {
    List<int> ids = [];
    List<ItemFrequency<NPB>> processedNPB = [];

    // process npb to match parameters
    for (var nilai in nilaiList) {
      // only take nilai that match requested semester
      if (nilai.BaS.semester != semester) continue;

      for (var o in nilai.npb) {
        // separate npb by IT division or not
        if (isIT && o.pelajaran.divisi!.name != 'IT') continue;
        if (!isIT && o.pelajaran.divisi!.name == 'IT') continue;

        // if item exist, update item frequency
        if (ids.contains(o.no)) {
          processedNPB.firstWhere((element) => element.item.no==o.no).n++;
          continue;
        }
        // otherwise add item to data
        ids.add(o.no);
        processedNPB.add(ItemFrequency(o, n: 1));
      }
    }

    return processedNPB;
  }
}