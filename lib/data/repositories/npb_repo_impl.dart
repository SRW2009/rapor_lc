
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';
import 'package:rapor_lc/domain/repositories/npb_repo.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class NPBRepositoryImpl extends NPBRepository {
  @override
  Future<RequestStatus> createNPB(NPB npb) {
    // TODO: implement createNPB
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> deleteNPB(List<String> ids) {
    // TODO: implement deleteNPB
    throw UnimplementedError();
  }

  @override
  Future<NPB> getNPB(int id) {
    // TODO: implement getNPB
    throw UnimplementedError();
  }

  @override
  Future<List<NPB>> getNPBList(String santriNis) {
    // TODO: implement getNPBList
    throw UnimplementedError();
  }

  @override
  Future<List<NPB>> getNPBListAdmin() async {
    // TODO: implement getNPBListAdmin
    await Future.delayed(const Duration(seconds: 3));
    return List<NPB>.generate(
        10, (index) => (index % 1 == 0)
        ? NPBMO(index,
        Santri('12345678', 'SantriBoy'), 1, '2020/2021',
        MataPelajaran(1, Divisi(1, 'MPP', 'KarateGuy'), 'Karate'),
        '70%', 1)
        : NPBPO(index,
        Santri('12345678', 'SantriBoy'), 1, '2020/2021',
        MataPelajaran(1, Divisi(1, 'MPP', 'KarateGuy'), 'Karate'),
        '70%'));
  }

  @override
  Future<RequestStatus> updateNPB(NPB newNPB) {
    // TODO: implement updateNPB
    throw UnimplementedError();
  }
}