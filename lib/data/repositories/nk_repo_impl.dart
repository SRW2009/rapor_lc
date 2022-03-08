
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/repositories/nk_repo.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class NKRepositoryImpl extends NKRepository {
  @override
  Future<RequestStatus> createNK(NK nk) {
    // TODO: implement createNK
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> deleteNK(List<String> ids) {
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
  Future<List<NK>> getNKListAdmin() async {
    // TODO: implement getNKListAdmin
    await Future.delayed(const Duration(seconds: 3));
    return List<NK>.generate(
        10, (index) => NK(index, Santri('12345678', 'SantriBoy'),
        1, '2020/2021', 1, 'Inisiatif', 76, 74, 78, 75, 'B'));
  }

  @override
  Future<RequestStatus> updateNK(NK newNK) {
    // TODO: implement updateNK
    throw UnimplementedError();
  }
}