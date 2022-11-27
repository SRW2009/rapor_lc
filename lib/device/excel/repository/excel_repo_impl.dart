import 'dart:io';

import 'package:excel/excel.dart';
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/data/repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/domain/entities/nhb_block.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb_semester.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repositories/excel_repo.dart';

typedef MapelName = String;
typedef SantriNis = String;

class ExcelRepositoryImpl extends ExcelRepository with _ExcelRepositoryMixin {
  @override
  Future<List<int>?> exportNilai() async {
    // collect all nilai list
    var nilaiList = await NilaiRepositoryImpl().getNilaiList(null);
    nilaiList.sort();

    // separate nilai list by their mapel name, then santri nis, then timeline
    final sheetsData = <MapelName, Map<SantriNis, Map<Timeline, List<Nilai>>>>{};
    for (var nilai in nilaiList) {
      final santriNis = nilai.santri.nis!;
      final timeline = nilai.timeline;

      // iterate nilai nhb semester
      for (var o in nilai.nhbSemester) {
        final mapel = o.pelajaran.name;

        // create entry if key doesn't exist
        sheetsData.update(mapel, (value) => value, ifAbsent: () => {});
        sheetsData[mapel]!.update(santriNis, (value) => value, ifAbsent: () => {});
        sheetsData[mapel]![santriNis]!.update(timeline, (value) => value, ifAbsent: () => []);

        final nilaiListRef = sheetsData[mapel]![santriNis]![timeline]!;
        // if nilai already exist, insert nhb record there
        try {
          nilaiListRef.singleWhere((element) => element == nilai).nhbSemester.add(o);
        }
        // otherwise, create new nilai instance and insert nhb record there
        on StateError {
          final n = nilai.cloneWithoutData();
          n.nhbSemester.add(o);
          nilaiListRef.add(n);
        }
      }

      // iterate nilai nhb block
      for (var o in nilai.nhbBlock) {
        final mapel = o.pelajaran.name;

        // create entry if key doesn't exist
        sheetsData.update(mapel, (value) => value, ifAbsent: () => {});
        sheetsData[mapel]!.update(santriNis, (value) => value, ifAbsent: () => {});
        sheetsData[mapel]![santriNis]!.update(timeline, (value) => value, ifAbsent: () => []);

        final nilaiListRef = sheetsData[mapel]![santriNis]![timeline]!;
        // if nilai already exist, insert nhb record there
        try {
          nilaiListRef.singleWhere((element) => element == nilai).nhbBlock.add(o);
        }
        // otherwise, create new nilai instance and insert nhb record there
        on StateError {
          final n = nilai.cloneWithoutData();
          n.nhbBlock.add(o);
          nilaiListRef.add(n);
        }
      }

      // iterate nilai npb
      for (var o in nilai.npb) {
        final mapel = o.pelajaran.name;

        // create entry if key doesn't exist
        sheetsData.update(mapel, (value) => value, ifAbsent: () => {});
        sheetsData[mapel]!.update(santriNis, (value) => value, ifAbsent: () => {});
        sheetsData[mapel]![santriNis]!.update(timeline, (value) => value, ifAbsent: () => []);

        final nilaiListRef = sheetsData[mapel]![santriNis]![timeline]!;
        // if nilai already exist, insert nhb record there
        try {
          nilaiListRef.singleWhere((element) => element == nilai).npb.add(o);
        }
        // otherwise, create new nilai instance and insert nhb record there
        on StateError {
          final n = nilai.cloneWithoutData();
          n.npb.add(o);
          nilaiListRef.add(n);
        }
      }

      // iterate nilai nk
      sheetsData['NK'] = {};
      for (var o in nilai.nk) {

        // create entry if key doesn't exist
        sheetsData['NK']!.update(santriNis, (value) => value, ifAbsent: () => {});
        sheetsData['NK']![santriNis]!.update(timeline, (value) => value, ifAbsent: () => []);

        final nilaiListRef = sheetsData['NK']![santriNis]![timeline]!;
        // if nilai already exist, insert nk record there
        try {
          nilaiListRef.singleWhere((element) => element == nilai).nk.add(o);
        }
        // otherwise, create new nilai instance and insert nk record there
        on StateError {
          final n = nilai.cloneWithoutData();
          n.nk.add(o);
          nilaiListRef.add(n);
        }
      }
    }

    // separate NK from NHB and NPB
    final nkSheetData = sheetsData['NK']!.cast<SantriNis, Map<Timeline, List<Nilai>>>();
    sheetsData.remove('NK');

    // create excel
    final excel = Excel.createExcel();

    // sheets for NHB and NPB
    for (var sheetName in sheetsData.keys) {
      Sheet sheet = excel[sheetName];

      /// HEADERS ///
      excel.merge(sheetName, CellIndex.indexByString('A1'), CellIndex.indexByString("A3"), customValue: 'Santri');
      excel.merge(sheetName, CellIndex.indexByString('B1'), CellIndex.indexByString("P1"), customValue: 'Nilai');
      excel.merge(sheetName, CellIndex.indexByString('B2'), CellIndex.indexByString("B3"), customValue: 'Timeline');
      excel.merge(sheetName, CellIndex.indexByString('C2'), CellIndex.indexByString("C3"), customValue: 'Tahun Ajaran');
      excel.merge(sheetName, CellIndex.indexByString('D2'), CellIndex.indexByString("I2"), customValue: 'NHB Semester');
      excel.merge(sheetName, CellIndex.indexByString('J2'), CellIndex.indexByString("O2"), customValue: 'NHB Block');
      sheet.cell(CellIndex.indexByString('P2'))..value = 'NPB'..cellStyle = headerCellStyle;

      sheet.cell(CellIndex.indexByString('A1'))
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString('B1'))
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString('B2'))
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString('C2'))
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString('D2'))
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString('J2'))
        ..cellStyle = headerCellStyle;

      // NHB Semester
      sheet.cell(CellIndex.indexByString("D3"))
        ..value = 'Nilai Harian'
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString("E3"))
        ..value = 'Nilai Bulanan'
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString("F3"))
        ..value = 'Nilai Projek'
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString("G3"))
        ..value = 'Nilai Akhir'
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString("H3"))
        ..value = 'Akumulasi'
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString("I3"))
        ..value = 'Predikat'
        ..cellStyle = headerCellStyle;
      // NHB Block
      sheet.cell(CellIndex.indexByString("J3"))
        ..value = 'Nilai Harian'
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString("K3"))
        ..value = 'Nilai Projek'
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString("L3"))
        ..value = 'Nilai Akhir'
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString("M3"))
        ..value = 'Deskripsi'
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString("N3"))
        ..value = 'Akumulasi'
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString("O3"))
        ..value = 'Predikat'
        ..cellStyle = headerCellStyle;
      // NPB
      sheet.cell(CellIndex.indexByString("P3"))
        ..value = 'N'
        ..cellStyle = headerCellStyle;

      /// CONTENTS ///
      var currentRow = 4;
      // santri
      for (var santriNis in sheetsData[sheetName]!.keys) {
        var startSantriRow = currentRow.toInt();

        // timeline
        for (var timeline in sheetsData[sheetName]![santriNis]!.keys) {
          var startTimelineRow = currentRow.toInt();

          // Nilai
          final nilaiList = sheetsData[sheetName]![santriNis]![timeline]!;
          nilaiList.sort();
          for (var nilai in nilaiList) {
            final nhbSemesterLength = nilai.nhbSemester.length;
            final nhbBlockLength = nilai.nhbBlock.length;
            final npbLength = nilai.npb.length;
            final maxLength = [nhbSemesterLength,nhbBlockLength,npbLength]
                .fold<int>(0, (prevValue, value) => prevValue>value?prevValue:value);

            for (var i = 0; i < maxLength; ++i) {
              // tahun ajaran
              sheet.cell(CellIndex.indexByString('C$currentRow'))
                ..value = nilai.tahunAjaran
                ..cellStyle = contentCellStyle;

              // nhb semester
              if (i < nilai.nhbSemester.length) {
                sheet.cell(CellIndex.indexByString('D$currentRow'))
                  ..value = nilai.nhbSemester[i].nilai_harian
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('E$currentRow'))
                  ..value = nilai.nhbSemester[i].nilai_bulanan
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('F$currentRow'))
                  ..value = nilai.nhbSemester[i].nilai_projek
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('G$currentRow'))
                  ..value = nilai.nhbSemester[i].nilai_akhir
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('H$currentRow'))
                  ..value = nilai.nhbSemester[i].akumulasi
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('I$currentRow'))
                  ..value = nilai.nhbSemester[i].predikat
                  ..cellStyle = contentCellStyle;
              }
              // nhb block
              if (i < nilai.nhbBlock.length) {
                sheet.cell(CellIndex.indexByString('J$currentRow'))
                  ..value = nilai.nhbBlock[i].nilai_harian
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('K$currentRow'))
                  ..value = nilai.nhbBlock[i].nilai_projek
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('L$currentRow'))
                  ..value = nilai.nhbBlock[i].nilai_akhir
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('M$currentRow'))
                  ..value = nilai.nhbBlock[i].description
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('N$currentRow'))
                  ..value = nilai.nhbBlock[i].akumulasi
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('O$currentRow'))
                  ..value = nilai.nhbBlock[i].predikat
                  ..cellStyle = contentCellStyle;
              }
              // npb
              if (i < nilai.npb.length) {
                sheet.cell(CellIndex.indexByString('P$currentRow'))
                  ..value = nilai.npb[i].n
                  ..cellStyle = contentCellStyle;
              }

              currentRow++;
            }
          }

          // append timeline
          if (startTimelineRow == currentRow-1) {
            sheet.cell(CellIndex.indexByString('B$startTimelineRow'))
              ..value = timeline.toExcelString()
              ..cellStyle = contentCellStyle;
          }
          else {
            excel.merge(
              sheetName,
              CellIndex.indexByString('B$startTimelineRow'),
              CellIndex.indexByString('B${currentRow - 1}'),
              customValue: timeline.toExcelString(),
            );
            sheet.cell(CellIndex.indexByString('B$startTimelineRow'))
              ..cellStyle = contentCellStyle;
          }
        }

        // append santri
        if (startSantriRow == currentRow-1) {
          sheet.cell(CellIndex.indexByString('A$startSantriRow'))
            ..value = santriNis
            ..cellStyle = contentCellStyle;
        }
        else {
          excel.merge(
            sheetName,
            CellIndex.indexByString('A$startSantriRow'),
            CellIndex.indexByString('A${currentRow - 1}'),
            customValue: santriNis,
          );
          sheet.cell(CellIndex.indexByString('A$startSantriRow'))
            ..cellStyle = contentCellStyle;
        }
      }
    }

    // sheets for NK
    Sheet sheetNK = excel['NK'];

    /// HEADERS ///
    excel.merge('NK', CellIndex.indexByString('A1'), CellIndex.indexByString("A3"), customValue: 'Santri');
    excel.merge('NK', CellIndex.indexByString('B1'), CellIndex.indexByString("I1"), customValue: 'Nilai');
    excel.merge('NK', CellIndex.indexByString('B2'), CellIndex.indexByString("B3"), customValue: 'Timeline');
    excel.merge('NK', CellIndex.indexByString('C2'), CellIndex.indexByString("C3"), customValue: 'Tahun Ajaran');
    excel.merge('NK', CellIndex.indexByString('D2'), CellIndex.indexByString("I2"), customValue: 'NK');
    sheetNK.cell(CellIndex.indexByString('A1'))
      ..cellStyle = headerCellStyle;
    sheetNK.cell(CellIndex.indexByString('B1'))
      ..cellStyle = headerCellStyle;
    sheetNK.cell(CellIndex.indexByString('B2'))
      ..cellStyle = headerCellStyle;
    sheetNK.cell(CellIndex.indexByString('C2'))
      ..cellStyle = headerCellStyle;
    sheetNK.cell(CellIndex.indexByString('D2'))
      ..cellStyle = headerCellStyle;
    sheetNK.cell(CellIndex.indexByString("D3"))
      ..value = 'Nama Variabel'
      ..cellStyle = headerCellStyle;
    sheetNK.cell(CellIndex.indexByString("E3"))
      ..value = 'Nilai Mesjid'
      ..cellStyle = headerCellStyle;
    sheetNK.cell(CellIndex.indexByString("F3"))
      ..value = 'Nilai Kelas'
      ..cellStyle = headerCellStyle;
    sheetNK.cell(CellIndex.indexByString("G3"))
      ..value = 'Nilai Asrama'
      ..cellStyle = headerCellStyle;
    sheetNK.cell(CellIndex.indexByString("H3"))
      ..value = 'Akumulatif'
      ..cellStyle = headerCellStyle;
    sheetNK.cell(CellIndex.indexByString("I3"))
      ..value = 'Predikat'
      ..cellStyle = headerCellStyle;

    /// CONTENTS ///
    var currentRow = 4;
    for (var santriNis in nkSheetData.keys) {
      var startSantriRow = currentRow.toInt();

      // Timeline
      for (var timeline in nkSheetData[santriNis]!.keys) {
        var startTimelineRow = currentRow.toInt();

        // Nilai
        final nilaiList = nkSheetData[santriNis]![timeline]!;
        nilaiList.sort();
        for (var nilai in nilaiList) {
          final maxLength = nilai.nk.length;

          for (var i = 0; i < maxLength; ++i) {
            // tahun ajaran
            sheetNK.cell(CellIndex.indexByString('C$currentRow'))
              ..value = nilai.tahunAjaran
              ..cellStyle = contentCellStyle;

            if (i < nilai.nk.length) {
              sheetNK.cell(CellIndex.indexByString('D$currentRow'))
                ..value = nilai.nk[i].nama_variabel
                ..cellStyle = contentCellStyle;
              sheetNK.cell(CellIndex.indexByString('E$currentRow'))
                ..value = nilai.nk[i].nilai_mesjid
                ..cellStyle = contentCellStyle;
              sheetNK.cell(CellIndex.indexByString('F$currentRow'))
                ..value = nilai.nk[i].nilai_kelas
                ..cellStyle = contentCellStyle;
              sheetNK.cell(CellIndex.indexByString('G$currentRow'))
                ..value = nilai.nk[i].nilai_asrama
                ..cellStyle = contentCellStyle;
              sheetNK.cell(CellIndex.indexByString('H$currentRow'))
                ..value = nilai.nk[i].akumulatif
                ..cellStyle = contentCellStyle;
              sheetNK.cell(CellIndex.indexByString('I$currentRow'))
                ..value = nilai.nk[i].predikat
                ..cellStyle = contentCellStyle;
            }

            currentRow++;
          }
        }

        // append timeline
        if (startTimelineRow == currentRow-1) {
          sheetNK.cell(CellIndex.indexByString('B$startTimelineRow'))
            ..value = timeline.toExcelString()
            ..cellStyle = contentCellStyle;
        }
        else {
          excel.merge(
            'NK',
            CellIndex.indexByString('B$startTimelineRow'),
            CellIndex.indexByString('B${currentRow - 1}'),
            customValue: timeline.toExcelString(),
          );
          sheetNK.cell(CellIndex.indexByString('B$startTimelineRow'))
            ..cellStyle = contentCellStyle;
        }
      }

      // append santri
      if (startSantriRow == currentRow-1) {
        sheetNK.cell(CellIndex.indexByString('A$startSantriRow'))
          ..value = santriNis
          ..cellStyle = contentCellStyle;
      }
      else {
        excel.merge(
          'NK',
          CellIndex.indexByString('A$startSantriRow'),
          CellIndex.indexByString('A${currentRow - 1}'),
          customValue: santriNis,
        );
        sheetNK.cell(CellIndex.indexByString('A$startSantriRow'))
          ..cellStyle = contentCellStyle;
      }
    }

    var defaultSheet = excel.getDefaultSheet();
    if (defaultSheet != null) excel.delete(defaultSheet);
    return excel.save();
  }

  @override
  Stream<String> importNilai(List<File> files) async* {
    // nilai list to put into database
    List<Nilai> nilaiList = [];

    // collect santri list
    yield 'Memuat daftar santri dari database ...';
    var santriList = await SantriRepositoryImpl().getSantriList();

    // collect mapel list
    yield 'Memuat daftar mapel dari database ...';
    var mapelList = await MataPelajaranRepositoryImpl().getMataPelajaranList();

    // for each files
    for (var file in files) {
      yield 'Membaca file ${file.path}';

      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      // process NHB and NPB
      for (var sheetName in excel.tables.keys) {
        // skip NK in this iteration
        if (sheetName == 'NK') continue;

        // check mapel existence and update mapel data
        final mapel = updateMapelDetail(mapelList, sheetName);
        final mapelBlock = updateMapelDetail(mapelList, sheetName, isBlock: true);
        if (mapel == null) {
          yield 'Tidak menemukan mapel semester dengan nama yang sesuai ($sheetName).';
          //continue;
        }
        if (mapelBlock == null) {
          yield 'Tidak menemukan mapel block dengan nama yang sesuai ($sheetName).';
          //continue;
        }
        if (mapel == null && mapelBlock == null) continue;

        yield 'Memuat nilai untuk mapel $sheetName ...';

        // declare editable nilai variable
        var currentNilai = Nilai.empty();

        // iterate excel rows, skip row 1 to 3
        for (var row in (excel.tables[sheetName]?.rows?..removeRange(0, 3)) ??
            <List<Data>>[]) {

          // if this student has been checked and marked not exist, skip this row
          if (currentNilai.santri.id == -2 && row.first == null) continue;

          // declare temporary variables
          int sHarian = -1, sBulanan = -1, sProjek = -1, sAkhir = -1;
          double sAkumulasi = -1; String sPredikat = '';
          int bHarian = -1, bProjek = -1, bAkhir = -1; String bDesk = '';
          double bAkumulasi = -1; String bPredikat = '';
          int n = -1;

          // iterate excel columns
          for (var col in row) {
            if (col == null) continue;
            var value = col.value;

            switch (col.colIndex) {
              // identify student
              case 0: currentNilai.santri = Santri(-1, '', nis: value.toString()); break;
              // identify timeline
              case 1: currentNilai.timeline = Timeline.fromString(value); break;
              // identify tahun ajaran
              case 2: currentNilai.tahunAjaran = value; break;
              // NHB Semester : nilai harian
              case 3: sHarian = numParse(value); break;
              // NHB Semester : nilai bulanan
              case 4: sBulanan = numParse(value); break;
              // NHB Semester : nilai projek
              case 5: sProjek = numParse(value); break;
              // NHB Semester : nilai akhir
              case 6: sAkhir = numParse(value); break;
              // NHB Block : nilai harian
              case 7: bHarian = numParse(value); break;
              // NHB Block : nilai projek
              case 8: bProjek = numParse(value); break;
              // NHB Block : nilai akhir
              case 9: bAkhir = numParse(value); break;
              // NHB Semester : deskripsi nilai
              case 10: bDesk = '$value'; break;
              // NPB : n
              case 11: n = value; break;
            }
          }

          /// check if NHB or NPB should be created
          bool shouldCreateNHBSemester = false;
          bool shouldCreateNHBBlock = false;
          bool shouldCreateNPB = false;
          // if NHB Semester is filled
          if (sHarian != -1 || sBulanan != -1 || sProjek != -1 || sAkhir != -1) {
            shouldCreateNHBSemester = true;

            sAkumulasi = NilaiCalculation.accumulate([
              sHarian, sBulanan, sProjek, sAkhir,
            ]);
            sPredikat = NilaiCalculation.toPredicate(sAkumulasi);
          }
          // if NHB Block is filled
          if (bHarian != -1 || bProjek != -1 || bAkhir != -1 || bDesk != '') {
            shouldCreateNHBBlock = true;

            bAkumulasi = NilaiCalculation.accumulate([
              bHarian, bProjek, bAkhir,
            ]);
            bPredikat = NilaiCalculation.toPredicate(bAkumulasi);
          }
          // if NPB is filled
          if (n != -1) {
            shouldCreateNPB = true;
          }

          // if student hasn't been checked, check student existence and update student data
          if (currentNilai.santri.id == -1) {
            final santri =
                updateStudentDetail(santriList, currentNilai.santri.nis!);

            if (santri == null) {
              // mark santri doesn't exist by setting id to -2, so iteration will skip until santri is changed
              currentNilai.santri =
                  Santri(-2, '', nis: currentNilai.santri.nis);
              yield 'Tidak menemukan santri dengan nis yang sesuai (${currentNilai.santri.nis}).';
              continue;
            }

            currentNilai.santri = santri;
          }

          if (shouldCreateNHBSemester || shouldCreateNHBBlock || shouldCreateNPB) {

            // get nilai index from nilai list that matches current nilai
            final nilaiIndex = nilaiList.indexOf(currentNilai);

            // if nilai doesn't exist, create new nilai record
            if (nilaiIndex == -1) {

              // add new value
              if (mapel != null) {
                if (shouldCreateNHBSemester) {
                  final nhb = NHBSemester(
                      1, mapel, sHarian, sBulanan, sProjek, sAkhir, sAkumulasi.toInt(), sPredikat);
                  currentNilai.nhbSemester.add(nhb);
                }
                if (shouldCreateNPB) {
                  final npb = NPB(1, mapel, n);
                  currentNilai.npb.add(npb);
                }
              }
              if (mapelBlock != null && shouldCreateNHBBlock) {
                final nhb = NHBBlock(
                    1, mapelBlock, bHarian, bProjek, bAkhir, bAkumulasi.toInt(), bPredikat, bDesk);
                currentNilai.nhbBlock.add(nhb);
              }

              // add nilai
              nilaiList.add(currentNilai);

              // clear nilai
              currentNilai = currentNilai.cloneWithoutData();
            } else {

              // add new value and update nilai
              if (mapel != null) {
                if (shouldCreateNHBSemester) {
                  final nhb = NHBSemester(nilaiList[nilaiIndex].nhbSemester.length + 1, mapel, sHarian,
                      sBulanan, sProjek, sAkhir, sAkumulasi.toInt(), sPredikat);
                  nilaiList[nilaiIndex].nhbSemester.add(nhb);
                }
                if (shouldCreateNPB) {
                  final npb = NPB(
                      nilaiList[nilaiIndex].npb.length + 1, mapel, n);
                  nilaiList[nilaiIndex].npb.add(npb);
                }
              }
              if (mapelBlock != null && shouldCreateNHBBlock) {
                final nhb = NHBBlock(nilaiList[nilaiIndex].nhbBlock.length + 1, mapelBlock, bHarian,
                    bProjek, bAkhir, bAkumulasi.toInt(), bPredikat, bDesk);
                nilaiList[nilaiIndex].nhbBlock.add(nhb);
              }
            }
          }
        }
      }

      // calculate NK
      if (excel.tables.keys.contains('NK')) {
        yield 'Memuat nilai NK ...';

        // declare editable nilai variable
        var currentNilai = Nilai.empty();

        // iterate excel rows, skip row 1 to 3
        for (var row in (excel.tables['NK']?.rows?..removeRange(0, 3)) ??
            <List<Data>>[]) {
          int mesjid = -1, kelas = -1, asrama = -1;
          String namaVariabel = '', predikat = '';
          double akumulatif = -1;

          // if this student has been checked and marked not exist, skip this row
          if (currentNilai.santri.id == -2 && row.first == null) continue;

          // iterate excel columns
          for (var col in row) {
            if (col == null) continue;
            var value = col.value;

            switch (col.colIndex) {
              // identify student
              case 0: currentNilai.santri = Santri(-1, '', nis: value.toString()); break;
              // identify Bulan and Semester
              case 1: currentNilai.timeline = Timeline.fromString(value); break;
              // identify tahun ajaran
              case 2: currentNilai.tahunAjaran = value; break;
              // variable name
              case 3: namaVariabel = value; break;
              // nilai mesjid
              case 4: mesjid = nkNumParse(namaVariabel, 'mesjid', value); break;
              // nilai kelas
              case 5: kelas = nkNumParse(namaVariabel, 'kelas', value); break;
              // nilai asrama
              case 6: asrama = nkNumParse(namaVariabel, 'asrama', value); break;
            }
          }

          bool shouldCreateNK = false;
          if (mesjid != -1 || kelas != -1 || asrama != -1) {
            shouldCreateNK = true;

            akumulatif = NilaiCalculation.accumulate([
              mesjid, kelas, asrama,
            ]);
            predikat = NilaiCalculation.toNKPredicate(akumulatif);
          }

          // if student hasn't been checked, check student existence and update student data
          if (currentNilai.santri.id == -1) {
            final santri = updateStudentDetail(santriList, currentNilai.santri.nis!);

            if (santri == null) {
              // mark santri doesn't exist by setting id to -2, so iteration will skip until santri is changed
              currentNilai.santri = Santri(-2, '', nis: currentNilai.santri.nis);

              yield 'Tidak menemukan santri dengan nis yang sesuai (${currentNilai.santri.nis}).';
              continue;
            }

            currentNilai.santri = santri;
          }

          if (shouldCreateNK) {

            // get nilai index from nilai list that matches current nilai
            final nilaiIndex = nilaiList.indexOf(currentNilai);

          // if nilai doesn't exist, create new nilai record
          if (nilaiIndex == -1) {
            final nk = NK(
                1, namaVariabel, mesjid, kelas, asrama, akumulatif.toInt(), predikat);
            currentNilai.nk = [nk];

            // add nilai
            nilaiList.add(currentNilai);

            // clear nilai
            currentNilai = currentNilai.cloneWithoutData();
          }
          // otherwise, assign NK to nilai record that matches
          else {
            final nk = NK(nilaiList[nilaiIndex].nk.length + 1, namaVariabel,
                mesjid, kelas, asrama, akumulatif.toInt(), predikat);
            if (nilaiList[nilaiIndex].nk.isEmpty)
              nilaiList[nilaiIndex].nk = [nk];
            else
              nilaiList[nilaiIndex].nk.add(nk);
            }
          }
        }
      }
    }

    // send data to database
    yield 'Mengirim hasil impor ke database ...';
    var count = 0;
    final max = nilaiList.length;
    for (var nilai in nilaiList) {
      var status = await NilaiRepositoryImpl().createNilai(nilai);
      if (status == RequestStatus.success) {
        yield 'Berhasil menambah nilai (${++count}/$max)';
      } else {
        yield 'Gagal menambah nilai (${++count}/$max)';
      }
    }
  }
}

mixin _ExcelRepositoryMixin {

  int numParse(dynamic value) => num.tryParse('$value')?.toInt()
      ?? int.tryParse('$value'.split(',')[0]) ?? 0;

  int nkNumParse(String variable, String type, dynamic value) => LoadedSettings.isNKGradeEnabled(variable, 'mesjid')
      ? num.tryParse('$value')?.toInt()
      ?? int.tryParse('$value'.split(',')[0])
      ?? -1
      : -1;

  Santri? updateStudentDetail(List<Santri> santriList, String santriNis) {
    try {
      final santri = santriList.singleWhere((e) => e.nis == santriNis);
      return santri;
    } on StateError {
      return null;
    }
  }

  MataPelajaran? updateMapelDetail(
      List<MataPelajaran> mapelList, String sheetName, {bool isBlock=false}) {
    try {
      final mapel = mapelList.singleWhere((e) =>
      e.name.toLowerCase() == sheetName.toLowerCase()
          && e.divisi.isBlock == isBlock
      );
      return mapel;
    } on StateError {
      return null;
    }
  }

  CellStyle headerCellStyle = CellStyle(
    fontFamily : getFontFamily(FontFamily.Calibri),
    verticalAlign: VerticalAlign.Center,
    horizontalAlign: HorizontalAlign.Center,
    backgroundColorHex: '#22BEFF',
    fontColorHex: '#000000',
    fontSize: 11,
  );

  CellStyle contentCellStyle = CellStyle(
    fontFamily : getFontFamily(FontFamily.Calibri),
    verticalAlign: VerticalAlign.Center,
    horizontalAlign: HorizontalAlign.Center,
    backgroundColorHex: '#FFFA15',
    fontColorHex: '#000000',
    fontSize: 11,
  );
}