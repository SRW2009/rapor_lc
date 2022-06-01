
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/domain/entities/bulan_and_semester.dart';
import 'package:rapor_lc/domain/entities/excel_obj.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repositories/excel_repo.dart';

mixin _ExcelRepositoryMixin {
  Santri? checkAndUpdateStudent(List<Santri> santriList, String santriNis) {
    try {
      final santri = santriList.singleWhere((e) => e.nis == santriNis);
      return santri;
    } on StateError {
      return null;
    }
  }

  MataPelajaran? checkAndUpdateMapel(List<MataPelajaran> mapelList, String sheetName) {
    try {
      final mapel = mapelList.singleWhere((e) => e.name == sheetName);
      return mapel;
    } on StateError {
      return null;
    }
  }
}

class ExcelRepositoryImpl extends ExcelRepository with _ExcelRepositoryMixin {
  @override
  Future<bool> exportNilai(ExcelObject object) async {
    var excel = Excel.createExcel();
    return true;
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
        final mapel = checkAndUpdateMapel(mapelList, sheetName);
        if (mapel == null)  {
          yield 'Tidak menemukan mapel dengan nama yang sesuai ($sheetName).';
          continue;
        }

        yield 'Memuat nilai untuk mapel $sheetName ...';

        // declare variables
        var currentNilai = Nilai.empty();
        bool createNewNilai = false;

        // iterate excel rows, skip row 1 to 3
        for (var row in (excel.tables[sheetName]?.rows?..removeRange(0, 3)) ?? <List<Data>>[]) {
          int harian = -1, bulanan = -1, projek = -1, akhir = -1, akumulasi = -1;
          String predikat = '', presensi = '', catatan = '';

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
                createNewNilai = true;
                break;
              // identify Bulan and Semester
              case 1:
                currentNilai.BaS = BulanAndSemester.fromString(value);
                createNewNilai = true;
                break;
              // identify tahun ajaran
              case 2: currentNilai.tahunAjaran = value;
                break;
              // NHB : nilai harian
              case 3: harian = value;
                break;
              // NHB : nilai bulanan
              case 4: bulanan = value;
                break;
              // NHB : nilai projek
              case 5: projek = value;
                break;
              // NHB : nilai akhir
              case 6: akhir = value;
                break;
              // NHB : nilai akumulasi
              case 7: akumulasi = value;
                break;
              // NHB : predikat
              case 8: predikat = value;
                break;
              // NPB : presensi
              case 9: presensi = '${(value*100).round()}%';
                break;
              // NPB : catatan
              case 10: catatan = value;
                break;
            }
          }

          // if student hasn't been checked, check student existence and update student data
          if (currentNilai.santri.id == -1) {
            final santri = checkAndUpdateStudent(santriList, currentNilai.santri.nis!);

            if (santri == null) {
              // mark santri doesn't exist by setting id to -2, so iteration will skip until santri is changed
              currentNilai.santri = Santri(-2, '', nis: currentNilai.santri.nis);
              yield 'Tidak menemukan santri dengan nis yang sesuai (${currentNilai.santri.nis}).';
              continue;
            }

            currentNilai.santri = santri;
          }

          // assign current nilai to nilai list
          if (createNewNilai) {
            createNewNilai = false;

            // clear old value
            currentNilai.nhb = [];
            currentNilai.npb = [];

            // add new value
            final nhb = NHB(1, mapel, harian,
                bulanan, projek, akhir, akumulasi, predikat);
            final npb = NPB(1, mapel, presensi, note: catatan);
            currentNilai.nhb.add(nhb);
            currentNilai.npb.add(npb);

            // add nilai
            nilaiList.add(Nilai.fromJson(currentNilai.toJson()));
          }
          else {
            // get nilai index from nilai list that matches current nilai
            final nilaiIndex = nilaiList.indexOf(currentNilai);

            // new value
            final nhb = NHB(nilaiList[nilaiIndex].nhb.length+1,
                mapel, harian, bulanan, projek, akhir, akumulasi, predikat);
            final npb = NPB(nilaiList[nilaiIndex].npb.length+1,
                mapel, presensi, note: catatan);

            // update nilai
            nilaiList[nilaiIndex].nhb.add(nhb);
            nilaiList[nilaiIndex].npb.add(npb);
          }
        }
      }
      // calculate NK
      if (excel.tables.keys.contains('NK')) {
        yield 'Memuat nilai NK ...';

        var currentNilai = Nilai.empty();
        // iterate excel rows, skip row 1 to 3
        for (var row in (excel.tables['NK']?.rows?..removeRange(0, 3)) ?? <List<Data>>[]) {
          int mesjid = -1, kelas = -1, asrama = -1, akumulatif = -1;
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
              case 2: currentNilai.tahunAjaran = value;
                break;
              // variable name
              case 3: namaVariabel = value;
                break;
              // nilai mesjid
              case 4: mesjid = value;
                break;
              // nilai kelas
              case 5: kelas = value;
                break;
              // nilai asrama
              case 6: asrama = value;
                break;
              // nilai akumulatif
              case 7: akumulatif = value;
                break;
              // predikat
              case 8: predikat = value;
                break;
            }
          }

          // if student hasn't been checked, check student existence and update student data
          if (currentNilai.santri.id == -1) {
            final santri = checkAndUpdateStudent(santriList, currentNilai.santri.nis!);

            if (santri == null) {
              // mark santri doesn't exist by setting id to -2, so iteration will skip until santri is changed
              currentNilai.santri = Santri(-2, '', nis: currentNilai.santri.nis);
              yield 'Tidak menemukan santri dengan nis yang sesuai (${currentNilai.santri.nis}).';
              continue;
            }

            currentNilai.santri = santri;
          }

          // get nilai index from nilai list that matches current nilai
          final nilaiIndex = nilaiList.indexOf(currentNilai);

          // if nilai doesn't exist, create new nilai record
          if (nilaiIndex == -1) {
            final nk = NK(1, namaVariabel, mesjid, kelas, asrama, akumulatif, predikat);
            currentNilai.nk = [nk];
            nilaiList.add(Nilai.fromJson(currentNilai.toJson()));
            currentNilai.nk.clear();
          }
          // otherwise, assign NK to nilai record that matches
          else {
            final nk = NK(nilaiList[nilaiIndex].nk.length+1,
                namaVariabel, mesjid, kelas, asrama, akumulatif, predikat);
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
        if (nilai.nk.isNotEmpty) print('${nilai.BaS.toReadableString()} - ${nilai.nk.first.nama_variabel}');

        var status = await NilaiRepositoryImpl().createNilai(nilai);
        if (status == RequestStatus.success) {
          yield 'Berhasil menambah nilai (${++count}/$max)';
        }
        else {
          yield 'Gagal menambah nilai (${++count}/$max)';
        }
      }
    }
  }
}