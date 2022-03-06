
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repositories/nhb_repo.dart';

class NHBRepositoryImpl extends NHBRepository {
  @override
  Future<RequestStatus> createNHB(NHB nhb) {
    // TODO: implement createNHB
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> deleteNHB(List<String> ids) {
    // TODO: implement deleteNHB
    throw UnimplementedError();
  }

  @override
  Future<NHB> getNHB(int id) {
    // TODO: implement getNHB
    throw UnimplementedError();
  }

  @override
  Future<List<NHB>> getNHBList(String santriNis) {
    // TODO: implement getNHBList
    throw UnimplementedError();
  }

  @override
  Future<List<NHB>> getNHBListAdmin() async {
    // TODO: implement getNHBListAdmin
    await Future.delayed(const Duration(seconds: 3));
    return List<NHB>.generate(
        10, (index) => NHB(index, Santri('12345678', 'SantriBoy'),
        MataPelajaran(1, Divisi(1, 'MPP', 'KarateGuy'), 'Karate'),
        1, '2020/2021', 80, 76, 74, 78, 75, 'B'));
  }

  @override
  Future<RequestStatus> updateNHB(NHB newNHB) {
    // TODO: implement updateNHB
    throw UnimplementedError();
  }
}