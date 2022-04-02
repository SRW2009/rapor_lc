
import 'dart:math';

import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/entities/bulan_and_semester.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

final _rand = Random();

const divisiList = <Divisi>[
  Divisi(0, 'IT'),
  Divisi(1, 'Tahfiz'),
  Divisi(2, 'Bahasa'),
  Divisi(3, 'MPP'),
];

final teacherList = List<Teacher>.generate(6, (i) => Teacher(i, 'Guru $i', divisi: divisiList[i % 4], isLeader: (i%2 == 0)));
final adminList = List<Admin>.generate(6, (i) => Admin(i, 'Admin $i'));
final santriList = List<Santri>.generate(6, (i) => Santri(i, 'Santri $i', nis: '$i$i$i$i$i$i$i$i'));

var mapelI = 0;
final mapelList = <MataPelajaran>[
  MataPelajaran(mapelI++, 'Tahfiz', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'QCB', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'Bahasa Arab', divisi: divisiList[2]),
  MataPelajaran(mapelI++, 'Bahasa Inggris', divisi: divisiList[2]),
  MataPelajaran(mapelI++, 'IT (DKV)', divisi: divisiList[0]),
  MataPelajaran(mapelI++, 'Fiqih', divisi: divisiList[3]),
  MataPelajaran(mapelI++, 'Aqidah', divisi: divisiList[3]),
  MataPelajaran(mapelI++, 'Kemandirian', divisi: divisiList[3]),
  MataPelajaran(mapelI++, 'Karate', divisi: divisiList[3]),
  MataPelajaran(mapelI++, 'Akhlak', divisi: divisiList[3]),
];
final mapelList_observation = <MataPelajaran>[
  MataPelajaran(mapelI++, 'RBQ 1', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'RBQ 2', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'RBQ 3', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'CFD 1', divisi: divisiList[0]),
  MataPelajaran(mapelI++, 'CFD 2', divisi: divisiList[0]),
  MataPelajaran(mapelI++, 'CFD 3', divisi: divisiList[0]),
  MataPelajaran(mapelI++, 'P. Adab', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'P. Ibadah', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'Pra QCB', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'RAQ', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'RHQ', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'ITMI', divisi: divisiList[0]),
];

final relationList = List<Relation>.generate(6, (i) => Relation(i, teacherList[i], santriList[i]));

var npbNo = 0;
final npbList = mapelList.map<NPB>((e) => NPBPO(npbNo++, e,
    '${_rand.nextInt(100)}%')).toList();
final npbList_observation = mapelList_observation.map<NPB>((e) => NPBMO(npbNo++, e,
    '${_rand.nextInt(100)}%', _rand.nextInt(3)+1)).toList();

var nhbNo = 0;
final nhbList = mapelList.map<NHB>((e) => NHB(nhbNo++, e,
    _rand.nextInt(100), _rand.nextInt(100), _rand.nextInt(100), _rand.nextInt(100), _rand.nextInt(100), 'B')).toList();
final nhbList_observation = mapelList_observation.map<NHB>((e) => NHB(nhbNo++, e,
    _rand.nextInt(100), _rand.nextInt(100), _rand.nextInt(100), _rand.nextInt(100), _rand.nextInt(100), 'B')).toList();

const _nkVariables = [
  'Inisiatif',
  'Kontrol Diri',
  'Kontrol Potensi',
  'Menghargai Karya'
];
final nkList = List<NK>.generate(_nkVariables.length, (i) => NK(i, _nkVariables[i],
    _rand.nextInt(100), _rand.nextInt(100), _rand.nextInt(100), _rand.nextInt(100), 'B'));

final nilai = Nilai(0, BulanAndSemester(7,2), '2020/2021', santriList.first,
    npb: npbList, nk: nkList, nhb: nhbList);
final nilai_observation = Nilai(1, BulanAndSemester(1,1), '2020/2021', santriList.first,
    npb: npbList_observation, nk: nkList, nhb: nhbList_observation);