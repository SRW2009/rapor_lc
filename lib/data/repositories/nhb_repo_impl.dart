
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/repositories/nhb_repo.dart';

class NHBRepositoryImpl extends NHBRepository {
  @override
  Future<RequestStatus> createNHB(NHB nhb) {
    // TODO: implement createNHB
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> deleteNHB(int id) {
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
  Future<List<NHB>> getNHBListAdmin() {
    // TODO: implement getNHBListAdmin
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> updateNHB(NHB newNHB) {
    // TODO: implement updateNHB
    throw UnimplementedError();
  }
}