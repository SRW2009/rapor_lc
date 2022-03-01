
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/repositories/npb_repo.dart';

class NPBRepositoryImpl extends NPBRepository {
  @override
  Future<RequestStatus> createNPB(NPB npb) {
    // TODO: implement createNPB
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> deleteNPB(int id) {
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
  Future<List<NPB>> getNPBListAdmin() {
    // TODO: implement getNPBListAdmin
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> updateNPB(NPB newNPB) {
    // TODO: implement updateNPB
    throw UnimplementedError();
  }
}