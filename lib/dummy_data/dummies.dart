
import 'dart:math';

import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb_block.dart';
import 'package:rapor_lc/domain/entities/nhb_semester.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';

final _rand = Random();

const divisiList = <Divisi>[
  Divisi(0, 'IT', false),
  Divisi(1, 'Tahfizh', false),
  Divisi(2, 'Bahasa', false),
  Divisi(3, 'MPP', false),
  Divisi(4, 'Kesantrian', false),
  Divisi(5, 'IT', true),
  Divisi(6, 'Tahfizh', true),
  Divisi(7, 'Bahasa Arab', true),
  Divisi(8, 'QCB', true),
  Divisi(9, 'Kemandirian', true),
];

final teacherList = List<Teacher>.generate(6, (i) => Teacher(i, 'Guru $i', divisi: divisiList[i % 4], isLeader: (i%2 == 0)));
final adminList = List<Admin>.generate(6, (i) => Admin(i, 'Admin $i'));
final santriList = List<Santri>.generate(6, (i) => Santri(i, 'Santri $i', nis: '$i$i$i$i$i$i$i$i'));

var mapelI = 0;
final mapelList_observation = <MataPelajaran>[
  MataPelajaran(mapelI++, 'RBQ 1', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'RBQ 2', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'RBQ 3', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'CFD 1', divisi: divisiList[0]),
  MataPelajaran(mapelI++, 'CFD 2', divisi: divisiList[0]),
  MataPelajaran(mapelI++, 'CFD 3', divisi: divisiList[0]),
  MataPelajaran(mapelI++, 'P. Adab', divisi: divisiList[3]),
  MataPelajaran(mapelI++, 'P. Ibadah', divisi: divisiList[3]),
  MataPelajaran(mapelI++, 'Pra QCB', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'RAQ', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'RHQ', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'ITMI', divisi: divisiList[0]),
];
final mapelList = <MataPelajaran>[
  MataPelajaran(mapelI++, 'Tahfizh', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'QCB', divisi: divisiList[1]),
  MataPelajaran(mapelI++, 'B. Arab', divisi: divisiList[2]),
  MataPelajaran(mapelI++, 'B. Inggris', divisi: divisiList[2]),
  MataPelajaran(mapelI++, 'IT (DKV)', divisi: divisiList[0]),
  MataPelajaran(mapelI++, 'Fiqih', divisi: divisiList[3]),
  MataPelajaran(mapelI++, 'Aqidah', divisi: divisiList[3]),
  MataPelajaran(mapelI++, 'Kemandirian', divisi: divisiList[3]),
  MataPelajaran(mapelI++, 'Karate', divisi: divisiList[3]),
  MataPelajaran(mapelI++, 'Akhlak', divisi: divisiList[3]),
  MataPelajaran(mapelI++, 'Inisiatif', divisi: divisiList[4]),
  MataPelajaran(mapelI++, 'Kontrol Diri', divisi: divisiList[4]),
  MataPelajaran(mapelI++, 'Kontrol Potensi', divisi: divisiList[4]),
  MataPelajaran(mapelI++, 'Menghargai Karya', divisi: divisiList[4]),
];
final mapelBlockList = <MataPelajaran>[
  MataPelajaran(mapelI++, 'Presentasi', divisi: divisiList[9]),
  MataPelajaran(mapelI++, 'Fast Respon', divisi: divisiList[9]),
  MataPelajaran(mapelI++, 'Analytic Retrieval', divisi: divisiList[9]),
  MataPelajaran(mapelI++, 'Istima\'', divisi: divisiList[7]),
  MataPelajaran(mapelI++, 'Kalam', divisi: divisiList[7]),
  MataPelajaran(mapelI++, 'Qiro\'ah', divisi: divisiList[7]),
  MataPelajaran(mapelI++, 'Kitabah', divisi: divisiList[7]),
  MataPelajaran(mapelI++, 'SWOT', divisi: divisiList[5]),
  MataPelajaran(mapelI++, 'K2IAM', divisi: divisiList[5]),
  MataPelajaran(mapelI++, 'Team Work', divisi: divisiList[5]),
  MataPelajaran(mapelI++, 'Sabak', divisi: divisiList[6]),
  MataPelajaran(mapelI++, 'Sabki', divisi: divisiList[6]),
  MataPelajaran(mapelI++, 'Uji Publik', divisi: divisiList[6]),
  MataPelajaran(mapelI++, 'Muhadharah', divisi: divisiList[8]),
  MataPelajaran(mapelI++, 'Fast Respon', divisi: divisiList[8]),
  MataPelajaran(mapelI++, 'Analytic Retrieval', divisi: divisiList[8]),
];

final relationList = List<Relation>.generate(6, (i) => Relation(i, teacherList[i], santriList[i]));

var nhbNo = mapelList.length;
final nhbList = mapelList
    .where((element) => element.divisi.name != 'Kesantrian')
    .map<NHBSemester>((e) => NHBSemester(--nhbNo, e, _rand.nextInt(100), _rand.nextInt(100),
    (e.divisi.name=='IT' ? _rand.nextInt(100) : -1), _rand.nextInt(100), _rand.nextInt(100), 'B')).toList();
final nhbList_observation = mapelList_observation
    .where((element) => element.divisi.name != 'Kesantrian')
    .map<NHBSemester>((e) => NHBSemester(nhbNo++, e, _rand.nextInt(100), _rand.nextInt(100),
    (e.divisi.name=='IT' ? _rand.nextInt(100) : -1), _rand.nextInt(100), _rand.nextInt(100), 'B')).toList();
final nhbBlockList = mapelBlockList
    .map<NHBBlock>((e) {
      final lorems = loremIpsum.split('.');
      final desc = lorems.getRange(0, (nhbNo%3)+1).join('.');
      return NHBBlock(nhbNo++, e, _rand.nextInt(100), _rand.nextInt(100), _rand.nextInt(100), _rand.nextInt(100), 'B', desc);
    }).toList();

var npbNo = 0;
final npbList_observation = mapelList_observation
    .where((e) => e.divisi.name != 'Kesantrian')
    .map<NPB>((e) => NPB(npbNo++, e, (npbNo > mapelList_observation.length~/2) ? 0 : 1))
    .toList();
final npbList = mapelList
    .where((e) => e.divisi.name != 'Kesantrian')
    .map<NPB>((e) => NPB(npbNo++, e, 1))
    .toList();

final _nkVariables = [...mapelList, ...mapelList_observation]
    .where((e) => e.divisi.name == 'Kesantrian')
    .toList();
List<NK> _createNkList() => List<NK>.generate(_nkVariables.length, (i) => NK(i, _nkVariables[i].name,
    _rand.nextInt(70)+30, _rand.nextInt(70)+30, _rand.nextInt(70)+30, _rand.nextInt(70)+30, 'B'));

var nilaiNo = 0;
final nilai_s_odd = Nilai(nilaiNo++, Timeline(1,1,1,1), '2020/2021', santriList.first,
    npb: npbList_observation, nk: _createNkList(), nhbSemester: nhbList_observation, isObservation: true);
final nilai_s_even = Nilai(nilaiNo++, Timeline(7,2,1,1), '2020/2021', santriList.first,
    npb: npbList, nk: _createNkList(), nhbSemester: nhbList);

final nilai_s_even2 = Nilai(nilaiNo++, Timeline(9,2,1,1), '2020/2021', santriList.first,
    npb: npbList, nk: _createNkList(), nhbSemester: nhbList);

final nilai_s_even3 = Nilai(nilaiNo++, Timeline(12,2,1,1), '2020/2021', santriList.first,
    npb: npbList, nk: _createNkList(), nhbSemester: nhbList);

final nilai_block1 = Nilai(nilaiNo++, Timeline(1,1,1,1), '2020/2021', santriList.first,
    nhbBlock: nhbBlockList.getRange(7, 10).toList());
final nilai_block2 = Nilai(nilaiNo++, Timeline(2,1,1,1), '2020/2021', santriList.first,
  nhbBlock: nhbBlockList.getRange(10, 13).toList());
final nilai_block3 = Nilai(nilaiNo++, Timeline(3,1,1,1), '2020/2021', santriList.first,
    nhbBlock: nhbBlockList.getRange(3, 7).toList());
final nilai_block4 = Nilai(nilaiNo++, Timeline(4,1,1,1), '2020/2021', santriList.first,
    nhbBlock: nhbBlockList.getRange(13, 16).toList());
final nilai_block5 = Nilai(nilaiNo++, Timeline(5,1,1,1), '2020/2021', santriList.first,
    nhbBlock: nhbBlockList.getRange(0, 3).toList());

final nilai_nks = <Nilai>[
  Nilai(
    4, Timeline(1,1,1,1), '2020/2021', santriList.first,
    npb: [], nk: _createNkList(), nhbSemester: [],
  ),
  Nilai(
    5, Timeline(2,1,1,1), '2020/2021', santriList.first,
    npb: [], nk: _createNkList(), nhbSemester: [],
  ),
  Nilai(
    6, Timeline(3,1,1,1), '2020/2021', santriList.first,
    npb: [], nk: _createNkList(), nhbSemester: [],
  ),
  Nilai(
    7, Timeline(4,1,1,1), '2020/2021', santriList.first,
    npb: [], nk: _createNkList(), nhbSemester: [],
  ),
  Nilai(
    8, Timeline(5,1,1,1), '2020/2021', santriList.first,
    npb: [], nk: _createNkList(), nhbSemester: [],
  ),
  Nilai(
    9, Timeline(6,1,1,1), '2020/2021', santriList.first,
    npb: [], nk: _createNkList(), nhbSemester: [],
  ),Nilai(
    10, Timeline(7,2,1,1), '2020/2021', santriList.first,
    npb: [], nk: _createNkList(), nhbSemester: [],
  ),Nilai(
    11, Timeline(8,2,1,1), '2020/2021', santriList.first,
    npb: [], nk: _createNkList(), nhbSemester: [],
  ),Nilai(
    12, Timeline(9,2,1,1), '2020/2021', santriList.first,
    npb: [], nk: _createNkList(), nhbSemester: [],
  ),
  Nilai(
    13, Timeline(10,2,1,1), '2020/2021', santriList.first,
    npb: [], nk: _createNkList(), nhbSemester: [],
  ),
  Nilai(
    14, Timeline(11,2,1,1), '2020/2021', santriList.first,
    npb: [], nk: _createNkList(), nhbSemester: [],
  ),
  Nilai(
    15, Timeline(12,2,1,1), '2020/2021', santriList.first,
    npb: [], nk: _createNkList(), nhbSemester: [],
  ),
];

String get loremIpsum =>
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
    'Cras mauris arcu, convallis at nunc semper, elementum rhoncus felis. '
    'Fusce tristique enim sit amet aliquet dictum. '
    'Mauris elementum nisl eget nibh fringilla, non dictum sem varius. '
    'Proin ac sollicitudin sapien, eget ornare massa. '
    'Donec bibendum, purus at gravida euismod, nibh nisl tristique mauris, ac blandit leo justo in magna. '
    'Phasellus iaculis purus sed pellentesque porttitor. '
    'Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.';