
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/repositories/nk_repo.dart';

class NKRepositoryImpl extends NKRepository {
  @override
  Future<RequestStatus> createNK(NK nk) {
    // TODO: implement createNK
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> deleteNK(int id) {
    // TODO: implement deleteNK
    throw UnimplementedError();
  }

  @override
  Future<NK> getNK(int id) {
    // TODO: implement getNK
    throw UnimplementedError();
  }

  @override
  Future<List<NK>> getNKList(String santriNis) {
    // TODO: implement getNKList
    throw UnimplementedError();
  }

  @override
  Future<List<NK>> getNKListAdmin() {
    // TODO: implement getNKListAdmin
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> updateNK(NK newNK) {
    // TODO: implement updateNK
    throw UnimplementedError();
  }
}