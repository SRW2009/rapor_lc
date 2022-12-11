
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/common/item_frequency.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/device/pdf/pdf_global_setting.dart';
import 'package:rapor_lc/device/pdf/pdf_object.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb_block.dart';
import 'package:rapor_lc/domain/entities/nhb_semester.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';

class ChartDatasetsFactory {
  static NHBDatasets buildNHBDatasets(List<NHBSemester> contents) {
    var divisiList = <String>[];
    var mapelList = <MataPelajaran>[];

    // collect every mapel and divisi that appeared
    for (var nhb in contents) {
      if (!mapelList.contains(nhb.pelajaran)) {
        mapelList.add(nhb.pelajaran);
        if (!divisiList.contains(nhb.pelajaran.divisi.name)) divisiList.add(
            nhb.pelajaran.divisi.name);
      }
    }

    // ( Bug Workaround ) if mapelList only contain 1 or 2,
    // add dummy data so their bar in chart will go to center
    bool createDummy = false;
    if (mapelList.length <= 2) {
      createDummy = true;

      final divisi = mapelList.first.divisi;
      mapelList.insert(0, MataPelajaran(-1, ':::', divisi: divisi));
      mapelList.add(MataPelajaran(-2, '::::', divisi: divisi));
    }

    // parse map type to the desired type
    Map<String, int> mapelValueMap = contents.asMap()
        .map<String, int>((key, value) => MapEntry(value.pelajaran.name, value.akumulasi));

    // create dummy in mapelValueMap
    if (createDummy) {
      mapelValueMap[':::'] = 0;
      mapelValueMap['::::'] = 0;
    }

    // counter for color variation in chart
    var colorI = 0;

    // process datasets
    final datasets = divisiList
        .map<BarDataSet>((e) =>
        BarDataSet(
          color: PDFSetting.defaultColorsGroup[colorI++],
          legend: e,
          width: 12,
          data: [
            for (var i = 0; i < mapelList.length; i++)
              LineChartValue(
                i.toDouble(),
                (mapelList.elementAt(i).divisi.name == e)
                    ? mapelValueMap[mapelList.elementAt(i).name]!.toDouble()
                    : 0.0,
              ),
          ],
        )).toList();

    return NHBDatasets(mapelList, datasets);
  }

  static NPBDatasets buildNPBDatasets(List<Nilai> nilaiList, int semester,
      bool isIT) {
    /*
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
          if (!divisiList.contains(e.pelajaran.divisi!.name)) divisiList.add(
              e.pelajaran.divisi!.name);
        }
      }

      // add processed nilai to data
      processedNilaiList.add(nilai.clone()
        ..npb = npbList);
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
    processedNilaiList.sort((a, b) => a.timeline.compareTo(b.timeline));

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
              if (nilai.timeline.semester <= semester
                  && _presensiToInt(e.presensi) > value)
                return _presensiToInt(e.presensi);
              return value;
            },
            ifAbsent: () {
              if (nilai.timeline.semester <= semester)
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
        .map<BarDataSet>((e) =>
        BarDataSet(
          color: _Colors[colorI++],
          axis: Axis.vertical,
          legend: e,
          width: 8,
          data: [
            for (var i = 0; i < mapelValueMap.entries.length; i++)
              LineChartValue(
                (mapelList
                    .elementAt(i)
                    .divisi!
                    .name == e)
                    ? mapelValueMap[mapelList
                    .elementAt(i)
                    .name]!.toDouble()
                    : 0.0,
                i.toDouble(),
              ),
          ],
        )).toList();

    return NPBDatasets(mapelList, datasets);*/
    return NPBDatasets([], []);
  }

  static NKDatasets buildNKDatasets(List<Nilai> nilaiList, Timeline timeline) {
    // process value of each variable
    // variable_name: nilai_title: [ month_1_val, month_2_val, ... ]
    Map<String, Map<String, List<ItemFrequency<double>>>> variableValueMap = {};

    for (var nilai in nilaiList) {
      // only take nilai that match requested timeline
      if (!nilai.timeline.isTimelineMatch(timeline)) continue;

      // determine which month this nilai nk for
      var monthIndex = nilai.timeline.semester.isOdd ? nilai.timeline.bulan - 1 : nilai
          .timeline.bulan - 7;

      // update every variable's value for this month
      for (var o in nilai.nk) {
        // update value
        variableValueMap.update(
          o.nama_variabel,
              (v) {
            // calculate average of both value
            v.update(
              'asrama',
                  (value) {
                if (o.nilai_asrama != -1
                    && LoadedSettings.isNKGradeEnabled(o.nama_variabel, 'asrama'))
                  value[monthIndex]
                    ..item += o.nilai_asrama..n += 1;

                return value;
              },
            );
            v.update(
              'kelas',
                  (value) {
                if (o.nilai_kelas != -1
                    && LoadedSettings.isNKGradeEnabled(o.nama_variabel, 'kelas'))
                  value[monthIndex]
                    ..item += o.nilai_kelas..n += 1;

                return value;
              },
            );
            v.update(
              'mesjid',
                  (value) {
                if (o.nilai_mesjid != -1
                    && LoadedSettings.isNKGradeEnabled(o.nama_variabel, 'mesjid'))
                  value[monthIndex]
                    ..item += o.nilai_mesjid..n += 1;

                return value;
              },
            );
            return v;
          },
          ifAbsent: () =>
          {
            'asrama': (o.nilai_asrama != -1
                && LoadedSettings.isNKGradeEnabled(o.nama_variabel, 'asrama'))
                ? List.generate(6, (index) =>
            (index == monthIndex)
                ? ItemFrequency(o.nilai_asrama.toDouble(), n: 1)
                : ItemFrequency(0))
                : List.generate(6, (index) => ItemFrequency(0)),
            'kelas': (o.nilai_kelas != -1
                && LoadedSettings.isNKGradeEnabled(o.nama_variabel, 'kelas'))
                ? List.generate(6, (index) =>
            (index == monthIndex)
                ? ItemFrequency(o.nilai_kelas.toDouble(), n: 1)
                : ItemFrequency(0))
                : List.generate(6, (index) => ItemFrequency(0)),
            'mesjid': (o.nilai_mesjid != -1
                && LoadedSettings.isNKGradeEnabled(o.nama_variabel, 'mesjid'))
                ? List.generate(6, (index) =>
            (index == monthIndex)
                ? ItemFrequency(o.nilai_mesjid.toDouble(), n: 1)
                : ItemFrequency(0))
                : List.generate(6, (index) => ItemFrequency(0)),
          },
        );
      }
    }

    // this variable will be passed to nk contents
    Map<String, Map<String, List<double>>> contentValueMap = {};

    // accumulate each value into it's respective month and group them based on variable name
    Map<String, List<double?>> accumulatedValueMap = {};
    for (var key in variableValueMap.keys) {
      final asramaList = List<double>.generate(6, (index) => -1);
      final kelasList = List<double>.generate(6, (index) => -1);
      final mesjidList = List<double>.generate(6, (index) => -1);

      for (var i = 0; i < 6; ++i) {
        // asrama
        var asrama = variableValueMap[key]!['asrama']![i];
        var asramaValue = asrama.item/asrama.n;
        if (!asramaValue.isNaN) asramaList[i] = asramaValue;
        // kelas
        var kelas = variableValueMap[key]!['kelas']![i];
        var kelasValue = kelas.item/kelas.n;
        if (!kelasValue.isNaN) kelasList[i] = kelasValue;
        // mesjid
        var mesjid = variableValueMap[key]!['mesjid']![i];
        var mesjidValue = mesjid.item/mesjid.n;
        if (!mesjidValue.isNaN) mesjidList[i] = mesjidValue;
      }

      final accumulatedList = List<double?>.generate(6, (i) {
        if (asramaList[i] == -1 && kelasList[i] == -1 && mesjidList[i] == -1) return null;
        return NilaiCalculation.accumulate([asramaList[i], kelasList[i], mesjidList[i]]);
      });

      accumulatedValueMap[key] = accumulatedList;

      // work on nk content
      contentValueMap[key] = {
        'asrama': asramaList,
        'kelas': kelasList,
        'mesjid': mesjidList,
      };
    }

    // counter for color variation in chart
    var colorI = 0;

    // process datasets
    final datasets = accumulatedValueMap.entries
        .map<LineDataSet>((e) =>
        LineDataSet(
            legend: e.key,
            color: PDFSetting.defaultColorsGroup[colorI++],
            lineWidth: 3.2,
            pointSize: 4.0,
            data: List<LineChartValue>.generate(6, (index) =>
                LineChartValue(index.toDouble(), e.value[index] ?? 0.0),
            ))).toList();

    return NKDatasets(datasets, contentValueMap);
  }
}

class TableContentsFactory {
  static NHBContents buildNHBContents(List<Nilai> nilaiList, Timeline timeline) {
    // MO = Masa Observasi
    // PO = Paska Observasi
    Map<MataPelajaran, Map<String, ItemFrequency<double>>> nhbMOValueMap = {};
    Map<MataPelajaran, Map<String, ItemFrequency<double>>> nhbPOValueMap = {};
    final maps = {
      'mo': nhbMOValueMap,
      'po': nhbPOValueMap,
    };

    // process nhb to match parameters
    for (var nilai in nilaiList) {

      // only take nilai that match requested timeline
      if (!nilai.timeline.isTimelineMatch(timeline)) continue;

      // decide which period this nilai belongs to
      String period = (nilai.isObservation) ? 'mo' : 'po';

      for (var o in nilai.nhbSemester) {
        // update value
        maps[period]!.update(
          o.pelajaran,
          (v) {
            v.update(
              'harian',
              (value) =>
                (o.nilai_harian!=-1)
                  ? (value..item+=o.nilai_harian..n+=1)
                  : value,
            );
            v.update(
              'bulanan',
              (value) =>
                (o.nilai_bulanan!=-1)
                  ? (value..item+=o.nilai_bulanan..n+=1)
                  : value,
            );
            v.update(
              'projek',
              (value) =>
                (o.nilai_projek!=-1)
                  ? (value..item+=o.nilai_projek..n+=1)
                  : value,
            );
            v.update(
              'akhir',
              (value) =>
                (o.nilai_akhir!=-1)
                  ? (value..item+=o.nilai_akhir..n+=1)
                  : value,
            );
            return v;
          },
          ifAbsent: () => {
            'harian': (o.nilai_harian!=-1)
                ? ItemFrequency(o.nilai_harian.toDouble(), n: 1)
                : ItemFrequency(0),
            'bulanan': (o.nilai_bulanan!=-1)
                ? ItemFrequency(o.nilai_bulanan.toDouble(), n: 1)
                : ItemFrequency(0),
            'projek': (o.nilai_projek!=-1)
                ? ItemFrequency(o.nilai_projek.toDouble(), n: 1)
                : ItemFrequency(0),
            'akhir': (o.nilai_akhir!=-1)
                ? ItemFrequency(o.nilai_akhir.toDouble(), n: 1)
                : ItemFrequency(0),
          },
        );
      }
    }

    var i = 0;
    return NHBContents(
      nhbMOValueMap.entries.map<NHBSemester>((entry) {
        var harian = entry.value['harian']!.item/entry.value['harian']!.n;
        var bulanan = entry.value['bulanan']!.item/entry.value['bulanan']!.n;
        var projek = entry.value['projek']!.item/entry.value['projek']!.n;
        var akhir = entry.value['akhir']!.item/entry.value['akhir']!.n;

        // NaN checker
        if (harian.isNaN) harian = -1;
        if (bulanan.isNaN) bulanan = -1;
        if (projek.isNaN) projek = -1;
        if (akhir.isNaN) akhir = -1;

        var acc = NilaiCalculation.accumulate([harian, bulanan, projek, akhir]);
        var pred = NilaiCalculation.toPredicate(acc);

        return NHBSemester(++i, entry.key, harian.toInt(), bulanan.toInt(), projek.toInt(), akhir.toInt(), acc.toInt(), pred);
      }).toList(),
      nhbPOValueMap.entries.map<NHBSemester>((entry) {
        var harian = entry.value['harian']!.item/entry.value['harian']!.n;
        var bulanan = entry.value['bulanan']!.item/entry.value['bulanan']!.n;
        var projek = entry.value['projek']!.item/entry.value['projek']!.n;
        var akhir = entry.value['akhir']!.item/entry.value['akhir']!.n;

        // NaN checker
        if (harian.isNaN) harian = -1;
        if (bulanan.isNaN) bulanan = -1;
        if (projek.isNaN) projek = -1;
        if (akhir.isNaN) akhir = -1;

        var acc = NilaiCalculation.accumulate([harian, bulanan, projek, akhir]);
        var pred = NilaiCalculation.toPredicate(acc);

        return NHBSemester(++i, entry.key, harian.toInt(), bulanan.toInt(), projek.toInt(), akhir.toInt(), acc.toInt(), pred);
      }).toList(),
    );
  }

  static NHBBlockContents buildNHBBlockContents(List<Nilai> nilaiList, Timeline timeline) {
    Map<MataPelajaran, Map<String, ItemFrequency<double>>> valueMap = {};
    Map<MataPelajaran, String> descMap = {};

    // sort nilai list
    nilaiList.sort();
    // process nhb to match parameters
    for (var nilai in nilaiList) {

      // only take nilai that match requested timeline
      if (!nilai.timeline.isTimelineMatch(timeline)) continue;

      for (var o in nilai.nhbBlock) {
        // update value
        valueMap.update(
          o.pelajaran,
          (v) {
            v.update(
              'harian',
                  (value) =>
              (o.nilai_harian!=-1)
                  ? (value..item+=o.nilai_harian..n+=1)
                  : value,
            );
            v.update(
              'projek',
                  (value) =>
              (o.nilai_projek!=-1)
                  ? (value..item+=o.nilai_projek..n+=1)
                  : value,
            );
            v.update(
              'akhir',
                  (value) =>
              (o.nilai_akhir!=-1)
                  ? (value..item+=o.nilai_akhir..n+=1)
                  : value,
            );
            return v;
          },
          ifAbsent: () => {
            'harian': (o.nilai_harian!=-1)
                ? ItemFrequency(o.nilai_harian.toDouble(), n: 1)
                : ItemFrequency(0),
            'projek': (o.nilai_projek!=-1)
                ? ItemFrequency(o.nilai_projek.toDouble(), n: 1)
                : ItemFrequency(0),
            'akhir': (o.nilai_akhir!=-1)
                ? ItemFrequency(o.nilai_akhir.toDouble(), n: 1)
                : ItemFrequency(0),
          },
        );
        descMap.update(o.pelajaran, (value) => o.description, ifAbsent: () => o.description);
      }
    }

    var i = 0;
    final values = valueMap.map<MataPelajaran, NHBBlock>((key, value) {
      var harian = value['harian']!.item/value['harian']!.n;
      var projek = value['projek']!.item/value['projek']!.n;
      var akhir = value['akhir']!.item/value['akhir']!.n;

      // NaN checker
      if (harian.isNaN) harian = -1;
      if (projek.isNaN) projek = -1;
      if (akhir.isNaN) akhir = -1;

      var acc = NilaiCalculation.accumulate([harian, projek, akhir]);
      var pred = NilaiCalculation.toPredicate(acc);

      return MapEntry(key, NHBBlock(++i, key, harian.toInt(),
          projek.toInt(), akhir.toInt(), acc.toInt(), pred, descMap[key]??''));
    });

    Map<String, List<NHBBlock>> finalValue = {};
    values.entries.forEach((element) {
      finalValue.update(
        element.key.divisi.name,
        (value) => value..add(element.value),
        ifAbsent: () => [element.value],
      );
    });
    return finalValue.entries.toList();
  }

  static NKContents buildNKContents(Map<String, Map<String, List<double>>> contents) {
    var i = 0;
    return contents.map<String, NK>((key, value) {
      var asrama = LoadedSettings.isNKGradeEnabled(key, 'asrama')
          ? NilaiCalculation.accumulateNaN(value['asrama']??[])
          : -1;
      var kelas = LoadedSettings.isNKGradeEnabled(key, 'kelas')
          ? NilaiCalculation.accumulateNaN(value['kelas']??[])
          : -1;
      var mesjid = LoadedSettings.isNKGradeEnabled(key, 'mesjid')
          ? NilaiCalculation.accumulateNaN(value['mesjid']??[])
          : -1;

      // NaN checker
      if (asrama.isNaN) asrama = -1;
      if (kelas.isNaN) kelas = -1;
      if (mesjid.isNaN) mesjid = -1;

      var acc = NilaiCalculation.accumulate([asrama, kelas, mesjid]);
      var pred = NilaiCalculation.toNKPredicate(acc);

      return MapEntry(key, NK(i++, key, mesjid.toInt(), kelas.toInt(), asrama.toInt(), acc.toInt(), pred));
    });
  }

  static NPBContents buildNPBContents(List<Nilai> nilaiList, Timeline requestedTimeline) {
    Map<int, NPB> mappedNPB = {};

    // process npb to match parameters
    for (var nilai in nilaiList) {
      // only take nilai that match requested timeline
      if (!nilai.timeline.isTimelineMatch(requestedTimeline)) continue;

      for (var o in nilai.npb) {
        if (o.n > (mappedNPB[o.pelajaran.id]?.n ?? -1)) {
          mappedNPB[o.pelajaran.id] = o;
        }
      }
    }

    return mappedNPB.values.toList()..sort((a,b) => b.n.compareTo(a.n));
  }
}