
import 'package:rapor_lc/domain/entities/npbmo.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import '../mata_pelajaran.dart';

final _santri = Santri('12345678', 'John Doe');

final contents = <NPBPO>[
  NPBPO(0, _santri, 2, '2021/2022', pelajaranList[0], '70%'),
  NPBPO(1, _santri, 2, '2021/2022', pelajaranList[1], '70%'),
  NPBPO(2, _santri, 2, '2021/2022', pelajaranList[2], '70%'),
  NPBPO(3, _santri, 2, '2021/2022', pelajaranList[3], '70%'),
  NPBPO(4, _santri, 2, '2021/2022', pelajaranList[4], '70%'),
  NPBPO(5, _santri, 2, '2021/2022', pelajaranList[5], '70%'),
  NPBPO(6, _santri, 2, '2021/2022', pelajaranList[6], '70%'),
  NPBPO(7, _santri, 2, '2021/2022', pelajaranList[7], '70%'),
];

final contents_observation = <NPBMO>[
  for (var e in pelajaranList_observation)
    NPBMO(0, _santri, 1, '2021/2022', e, 1, '70%'),
];