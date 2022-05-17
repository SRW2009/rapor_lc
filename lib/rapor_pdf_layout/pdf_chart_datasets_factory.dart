
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/npb.dart';

const _Colors = [PdfColors.blue, PdfColors.orange, PdfColors.grey, PdfColors.yellow, PdfColors.green];

class _NPBData {
  final List<MataPelajaran> mapels;
  final List<BarDataSet> datasets;

  _NPBData(this.mapels, this.datasets);
}

class DatasetsFactory {
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
          (value) => ((NilaiCalculation.accumulate([e.nilai_harian,e.nilai_bulanan,e.nilai_projek,e.nilai_akhir])+value)/2).round(),
          ifAbsent: () => NilaiCalculation.accumulate([e.nilai_harian,e.nilai_bulanan,e.nilai_projek,e.nilai_akhir]),
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
    var processedNilaiList = <Nilai>[];

    // process nilai list to match parameters
    for (var nilai in nilaiList) {
      // only take nilai that match requested semester
      if (semester != nilai.BaS.semester) continue;

      // add processed nilai to data
      processedNilaiList.add(Nilai.fromJson(nilai.toJson()));
    }

    // process value of each variable
    Map<String, List<int?>> varValuesMap = {};
    processedNilaiList.forEach((nilai) {
      // determine which month this nilai nk for
      var monthIndex = nilai.BaS.semester.isOdd ? nilai.BaS.bulan-1 : nilai.BaS.bulan-7;

      // update every variable's value for this month
      for (var o in nilai.nk) {
        varValuesMap.update(
          o.nama_variabel,
          (list) {
            var value = NilaiCalculation.accumulate([o.nilai_asrama, o.nilai_kelas, o.nilai_mesjid]);
            var accValue = (list[monthIndex] == null) ? value : NilaiCalculation.accumulate([list[monthIndex]!, value]);
            return list..replaceRange(monthIndex, monthIndex+1, [accValue]);
          },
          ifAbsent: () {
            var value = NilaiCalculation.accumulate([o.nilai_asrama, o.nilai_kelas, o.nilai_mesjid]);
            return [null,null,null,null,null,null]..replaceRange(monthIndex, monthIndex+1, [value]);
          },
        );
      }
    });

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