
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'divisi.dart';

var _pelI = 0;
final pelajaranList = <MataPelajaran>[
  MataPelajaran(_pelI++, divisiMap['tahfiz']!, 'Tahfiz'),
  MataPelajaran(_pelI++, divisiMap['tahfiz']!, 'QCB'),
  MataPelajaran(_pelI++, divisiMap['bahasa']!, 'Bahasa Arab'),
  MataPelajaran(_pelI++, divisiMap['bahasa']!, 'Bahasa Inggris'),
  MataPelajaran(_pelI++, divisiMap['it']!, 'IT (DKV)'),
  MataPelajaran(_pelI++, divisiMap['mpp']!, 'Fiqih'),
  MataPelajaran(_pelI++, divisiMap['mpp']!, 'Aqidah'),
  MataPelajaran(_pelI++, divisiMap['mpp']!, 'Kemandirian'),
  MataPelajaran(_pelI++, divisiMap['mpp']!, 'Karate'),
  MataPelajaran(_pelI++, divisiMap['mpp']!, 'Akhlak'),
];

final pelajaranList_observation = <MataPelajaran>[
  MataPelajaran(_pelI++, divisiMap['tahfiz']!, 'RBQ 1'),
  MataPelajaran(_pelI++, divisiMap['tahfiz']!, 'RBQ 2'),
  MataPelajaran(_pelI++, divisiMap['tahfiz']!, 'RBQ 3'),
  MataPelajaran(_pelI++, divisiMap['it']!, 'CFD 1'),
  MataPelajaran(_pelI++, divisiMap['it']!, 'CFD 2'),
  MataPelajaran(_pelI++, divisiMap['it']!, 'CFD 3'),
  MataPelajaran(_pelI++, divisiMap['tahfiz']!, 'P. Adab'),
  MataPelajaran(_pelI++, divisiMap['tahfiz']!, 'P. Ibadah'),
  MataPelajaran(_pelI++, divisiMap['tahfiz']!, 'Pra QCB'),
  MataPelajaran(_pelI++, divisiMap['tahfiz']!, 'RAQ'),
  MataPelajaran(_pelI++, divisiMap['tahfiz']!, 'RHQ'),
  MataPelajaran(_pelI++, divisiMap['it']!, 'ITMI'),
];