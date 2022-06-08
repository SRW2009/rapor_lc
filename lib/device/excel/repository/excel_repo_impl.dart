import 'dart:io';

import 'package:excel/excel.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/data/repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/domain/entities/bulan_and_semester.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repositories/excel_repo.dart';

mixin _ExcelRepositoryMixin {
  Santri? updateStudentDetail(List<Santri> santriList, String santriNis) {
    try {
      final santri = santriList.singleWhere((e) => e.nis == santriNis);
      return santri;
    } on StateError {
      return null;
    }
  }

  MataPelajaran? updateMapelDetail(
      List<MataPelajaran> mapelList, String sheetName) {
    try {
      final mapel = mapelList.singleWhere((e) => e.name.toLowerCase() == sheetName.toLowerCase());
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

class ExcelRepositoryImpl extends ExcelRepository with _ExcelRepositoryMixin {
  @override
  Future<List<int>?> exportNilai() async {
    // collect nilai list
    var nilaiList = await NilaiRepositoryImpl().getNilaiList();
    nilaiList.sort();

    // separate nilai list by their mapel, then Santri, then BaS
    // structure: <Mapel>: <Santri Nis>: <Bulan dan Semester>: List<Nilai>
    final sheetsData = <String, Map<String, Map<BulanAndSemester, List<Nilai>>>>{};
    for (var nilai in nilaiList) {
      final santriNis = nilai.santri.nis!;
      final BaS = nilai.BaS;

      // iterate nilai nhb
      for (var o in nilai.nhb) {
        final mapel = o.pelajaran.name;

        // create entry if key doesn't exist
        sheetsData.update(mapel, (value) => value, ifAbsent: () => {});
        sheetsData[mapel]!.update(santriNis, (value) => value, ifAbsent: () => {});
        sheetsData[mapel]![santriNis]!.update(BaS, (value) => value, ifAbsent: () => []);

        final nilaiListRef = sheetsData[mapel]![santriNis]![BaS]!;
        // if nilai already exist, insert nhb record there
        try {
          nilaiListRef.singleWhere((element) => element == nilai).nhb.add(o);
        }
        // otherwise, create new nilai instance and insert nhb record there
        on StateError {
          final n = nilai.clone()..nhb.clear()..npb.clear()..nk.clear();
          n.nhb.add(o);
          nilaiListRef.add(n);
        }
      }

      // iterate nilai npb
      for (var o in nilai.npb) {
        final mapel = o.pelajaran.name;

        // create entry if key doesn't exist
        sheetsData.update(mapel, (value) => value, ifAbsent: () => {});
        sheetsData[mapel]!.update(santriNis, (value) => value, ifAbsent: () => {});
        sheetsData[mapel]![santriNis]!.update(BaS, (value) => value, ifAbsent: () => []);

        final nilaiListRef = sheetsData[mapel]![santriNis]![BaS]!;
        // if nilai already exist, insert nhb record there
        try {
          nilaiListRef.singleWhere((element) => element == nilai).npb.add(o);
        }
        // otherwise, create new nilai instance and insert nhb record there
        on StateError {
          final n = nilai.clone()..nhb.clear()..npb.clear()..nk.clear();
          n.npb.add(o);
          nilaiListRef.add(n);
        }
      }

      // iterate nilai nk
      sheetsData['NK'] = {};
      for (var o in nilai.nk) {

        // create entry if key doesn't exist
        sheetsData['NK']!.update(santriNis, (value) => value, ifAbsent: () => {});
        sheetsData['NK']![santriNis]!.update(BaS, (value) => value, ifAbsent: () => []);

        final nilaiListRef = sheetsData['NK']![santriNis]![BaS]!;
        // if nilai already exist, insert nk record there
        try {
          nilaiListRef.singleWhere((element) => element == nilai).nk.add(o);
        }
        // otherwise, create new nilai instance and insert nk record there
        on StateError {
          final n = nilai.clone()..nhb.clear()..npb.clear()..nk.clear();
          n.nk.add(o);
          nilaiListRef.add(n);
        }
      }
    }

    // separate NK from NHB and NPB
    final nkSheetData = sheetsData['NK']!.cast<String, Map<BulanAndSemester, List<Nilai>>>();
    sheetsData.remove('NK');

    // create excel
    final excel = Excel.createExcel();
    // sheets for NHB and NPB
    for (var sheetName in sheetsData.keys) {
      Sheet sheet = excel[sheetName];

      /// HEADERS ///
      excel.merge(sheetName, CellIndex.indexByString('A1'), CellIndex.indexByString("A3"), customValue: 'Santri');
      excel.merge(sheetName, CellIndex.indexByString('B1'), CellIndex.indexByString("K1"), customValue: 'Nilai');
      excel.merge(sheetName, CellIndex.indexByString('B2'), CellIndex.indexByString("B3"), customValue: 'Bulan Dan Semester');
      excel.merge(sheetName, CellIndex.indexByString('C2'), CellIndex.indexByString("C3"), customValue: 'Tahun Ajaran');
      excel.merge(sheetName, CellIndex.indexByString('D2'), CellIndex.indexByString("I2"), customValue: 'NHB');
      excel.merge(sheetName, CellIndex.indexByString('J2'), CellIndex.indexByString("K2"), customValue: 'NPB');
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
      sheet.cell(CellIndex.indexByString("J3"))
        ..value = 'Presensi'
        ..cellStyle = headerCellStyle;
      sheet.cell(CellIndex.indexByString("K3"))
        ..value = 'Catatan'
        ..cellStyle = headerCellStyle;

      /// CONTENTS ///
      var currentRow = 4;
      // santri
      for (var santriNis in sheetsData[sheetName]!.keys) {
        var startSantriRow = currentRow.toInt();

        // Bulan and semester
        for (var bas in sheetsData[sheetName]![santriNis]!.keys) {
          var startBaSRow = currentRow.toInt();

          // Nilai
          final nilaiList = sheetsData[sheetName]![santriNis]![bas]!;
          nilaiList.sort();
          for (var nilai in nilaiList) {
            final nhbLength = nilai.nhb.length;
            final npbLength = nilai.npb.length;
            final maxLength = (nhbLength > npbLength) ? nhbLength : npbLength;

            for (var i = 0; i < maxLength; ++i) {
              // tahun ajaran
              sheet.cell(CellIndex.indexByString('C$currentRow'))
                ..value = nilai.tahunAjaran
                ..cellStyle = contentCellStyle;

              // nhb
              if (i < nilai.nhb.length) {
                sheet.cell(CellIndex.indexByString('D$currentRow'))
                  ..value = nilai.nhb[i].nilai_harian
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('E$currentRow'))
                  ..value = nilai.nhb[i].nilai_bulanan
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('F$currentRow'))
                  ..value = nilai.nhb[i].nilai_projek
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('G$currentRow'))
                  ..value = nilai.nhb[i].nilai_akhir
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('H$currentRow'))
                  ..value = nilai.nhb[i].akumulasi
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('I$currentRow'))
                  ..value = nilai.nhb[i].predikat
                  ..cellStyle = contentCellStyle;
              }
              // npb
              if (i < nilai.npb.length) {
                sheet.cell(CellIndex.indexByString('J$currentRow'))
                  ..value = nilai.npb[i].presensi
                  ..cellStyle = contentCellStyle;
                sheet.cell(CellIndex.indexByString('K$currentRow'))
                  ..value = nilai.npb[i].note
                  ..cellStyle = contentCellStyle;
              }

              currentRow++;
            }
          }

          // append Bulan and Semester
          if (startBaSRow == currentRow-1) {
            sheet.cell(CellIndex.indexByString('B$startBaSRow'))
              ..value = bas.toReadableString()
              ..cellStyle = contentCellStyle;
          }
          else {
            excel.merge(
              sheetName,
              CellIndex.indexByString('B$startBaSRow'),
              CellIndex.indexByString('B${currentRow - 1}'),
              customValue: bas.toReadableString(),
            );
            sheet.cell(CellIndex.indexByString('B$startBaSRow'))
              ..cellStyle = contentCellStyle;
          }
        }

        // append Santri
        if (startSantriRow == currentRow-1) {
          sheet.cell(CellIndex.indexByString('A$startSantriRow'))
              ..value = santriNis;
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
    excel.merge('NK', CellIndex.indexByString('B2'), CellIndex.indexByString("B3"), customValue: 'Bulan Dan Semester');
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
    // santri
    for (var santriNis in nkSheetData.keys) {
      var startSantriRow = currentRow.toInt();

      // Bulan and semester
      for (var bas in nkSheetData[santriNis]!.keys) {
        var startBaSRow = currentRow.toInt();

        // Nilai
        final nilaiList = nkSheetData[santriNis]![bas]!;
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

        // append Bulan and Semester
        if (startBaSRow == currentRow-1) {
          sheetNK.cell(CellIndex.indexByString('B$startBaSRow'))
            ..value = bas.toReadableString()
            ..cellStyle = contentCellStyle;
        }
        else {
          excel.merge(
            'NK',
            CellIndex.indexByString('B$startBaSRow'),
            CellIndex.indexByString('B${currentRow - 1}'),
            customValue: bas.toReadableString(),
          );
          sheetNK.cell(CellIndex.indexByString('B$startBaSRow'))
            ..cellStyle = contentCellStyle;
        }
      }

      // append Santri
      if (startSantriRow == currentRow-1) {
        sheetNK.cell(CellIndex.indexByString('A$startSantriRow'))
          ..value = santriNis;
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
        if (mapel == null) {
          yield 'Tidak menemukan mapel dengan nama yang sesuai ($sheetName).';
          continue;
        }

        yield 'Memuat nilai untuk mapel $sheetName ...';

        // declare local variables
        var currentNilai = Nilai.empty();

        // iterate excel rows, skip row 1 to 3
        for (var row in (excel.tables[sheetName]?.rows?..removeRange(0, 3)) ??
            <List<Data>>[]) {

          // if this student has been checked and marked not exist, skip this row
          if (currentNilai.santri.id == -2 && row.first == null) continue;

          // declare local variables
          int harian = -1, bulanan = -1, projek = -1, akhir = -1;
          double akumulasi = -1;
          String predikat = '', presensi = '', catatan = '';

          // iterate excel columns
          for (var col in row) {
            if (col == null) continue;
            var value = col.value;

            switch (col.colIndex) {
              // identify student
              case 0:
                currentNilai.santri = Santri(-1, '', nis: value.toString());
                break;
              // identify Bulan and Semester
              case 1:
                currentNilai.BaS = BulanAndSemester.fromString(value);
                break;
              // identify tahun ajaran
              case 2:
                currentNilai.tahunAjaran = value;
                break;
              // NHB : nilai harian
              case 3:
                harian = value;
                break;
              // NHB : nilai bulanan
              case 4:
                bulanan = value;
                break;
              // NHB : nilai projek
              case 5:
                projek = value;
                break;
              // NHB : nilai akhir
              case 6:
                akhir = value;
                break;
              // NPB : presensi
              case 7:
                presensi = '${(value * 100).round()}%';
                break;
              // NPB : catatan
              case 8:
                catatan = value;
                break;
            }
          }

          /// check if NHB or NPB should be created
          bool shouldCreateNHB = false;
          bool shouldCreateNPB = false;
          // if NHB is filled
          if (harian != -1 || bulanan != -1 || projek != -1 || akhir != -1) {
            shouldCreateNHB = true;

            akumulasi = NilaiCalculation.accumulate([
              harian, bulanan, projek, akhir,
            ]);
            predikat = NilaiCalculation.toPredicate(akumulasi);
          }
          // if NPB is filled
          if (presensi.isNotEmpty || catatan.isNotEmpty) {
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

          // assign current nilai to nilai list
          bool createNewNilai = !nilaiList.contains(currentNilai);
          if (createNewNilai) {
            createNewNilai = false;

            // clear old value
            currentNilai.nhb = [];
            currentNilai.npb = [];

            // add new value
            if (shouldCreateNHB) {
              final nhb = NHB(
                  1, mapel, harian, bulanan, projek, akhir, akumulasi.toInt(), predikat);
              currentNilai.nhb.add(nhb);
            }
            if (shouldCreateNPB) {
              final npb = NPB(1, mapel, presensi, note: catatan);
              currentNilai.npb.add(npb);
            }

            // add nilai
            if (shouldCreateNHB || shouldCreateNPB)
              nilaiList.add(Nilai.fromJson(currentNilai.toJson()));
          } else {
            // get nilai index from nilai list that matches current nilai
            final nilaiIndex = nilaiList.indexOf(currentNilai);

            // add new value and update nilai
            if (shouldCreateNHB) {
              final nhb = NHB(nilaiList[nilaiIndex].nhb.length + 1, mapel, harian,
                  bulanan, projek, akhir, akumulasi.toInt(), predikat);
              nilaiList[nilaiIndex].nhb.add(nhb);
            }
            if (shouldCreateNPB) {
              final npb = NPB(
                  nilaiList[nilaiIndex].npb.length + 1, mapel, presensi,
                  note: catatan);
              nilaiList[nilaiIndex].npb.add(npb);
            }
          }
        }
      }
      // calculate NK
      if (excel.tables.keys.contains('NK')) {
        yield 'Memuat nilai NK ...';

        var currentNilai = Nilai.empty();
        // iterate excel rows, skip row 1 to 3
        for (var row in (excel.tables['NK']?.rows?..removeRange(0, 3)) ??
            <List<Data>>[]) {
          int mesjid = -1, kelas = -1, asrama = -1;
          double akumulatif = -1;
          String namaVariabel = '', predikat = '';

          // if this student has been checked and marked not exist, skip this row
          if (currentNilai.santri.id == -2 && row.first == null) continue;

          // iterate excel columns
          for (var col in row) {
            if (col == null) continue;
            var value = col.value;

            switch (col.colIndex) {
              // identify student
              case 0:
                currentNilai.santri = Santri(-1, '', nis: value.toString());
                break;
              // identify Bulan and Semester
              case 1:
                currentNilai.BaS = BulanAndSemester.fromString(value);
                break;
              // identify tahun ajaran
              case 2:
                currentNilai.tahunAjaran = value;
                break;
              // variable name
              case 3:
                namaVariabel = value;
                break;
              // nilai mesjid
              case 4:
                mesjid = value;
                break;
              // nilai kelas
              case 5:
                kelas = value;
                break;
              // nilai asrama
              case 6:
                asrama = value;
                break;
            }
          }
          akumulatif = NilaiCalculation.accumulate([
            mesjid, kelas, asrama,
          ]);
          predikat = NilaiCalculation.toPredicate(akumulatif);

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

          // get nilai index from nilai list that matches current nilai
          final nilaiIndex = nilaiList.indexOf(currentNilai);

          // if nilai doesn't exist, create new nilai record
          if (nilaiIndex == -1) {
            final nk = NK(
                1, namaVariabel, mesjid, kelas, asrama, akumulatif.toInt(), predikat);
            currentNilai.nk = [nk];
            nilaiList.add(Nilai.fromJson(currentNilai.toJson()));
            currentNilai.nk.clear();
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

      // send data to database
      yield 'Mengirim hasil impor ke database ...';
      var count = 0;
      final max = nilaiList.length;
      for (var nilai in nilaiList) {
        if (nilai.nk.isNotEmpty)
          print(
              '${nilai.BaS.toReadableString()} - ${nilai.nk.first.nama_variabel}');

        var status = await NilaiRepositoryImpl().createNilai(nilai);
        if (status == RequestStatus.success) {
          yield 'Berhasil menambah nilai (${++count}/$max)';
        } else {
          yield 'Gagal menambah nilai (${++count}/$max)';
        }
      }
    }
  }
}
