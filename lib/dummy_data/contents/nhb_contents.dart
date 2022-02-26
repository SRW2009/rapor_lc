
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import '../mata_pelajaran.dart';

const _santri = Santri('12345678', 'John Doe');
final contents = List<NHB>.generate(pelajaranList.length,
        (i) => NHB(i, _santri, pelajaranList[i], 2, '2021/2022', 89, 77, 65, 80, 78, 'B')).toList();
final contents_observation = List<NHB>.generate(pelajaranList_observation.length,
        (i) => NHB(i, _santri, pelajaranList_observation[i], 1, '2021/2022', 89, 77, 65, 80, 78, 'B')).toList();