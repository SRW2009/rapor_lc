
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/repositories/mapel_repo.dart';

class MataPelajaranRepositoryImpl extends MataPelajaranRepository {
  @override
  Future<RequestStatus> createMataPelajaran(MataPelajaran nhb) {
    // TODO: implement createMataPelajaran
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> deleteMataPelajaran(List<String> ids) {
    // TODO: implement deleteMataPelajaran
    throw UnimplementedError();
  }

  @override
  Future<MataPelajaran> getMataPelajaran(int id) {
    // TODO: implement getMataPelajaran
    throw UnimplementedError();
  }

  @override
  Future<List<MataPelajaran>> getMataPelajaranList(String santriNis) {
    // TODO: implement getMataPelajaranList
    throw UnimplementedError();
  }

  @override
  Future<List<MataPelajaran>> getMataPelajaranListAdmin() {
    // TODO: implement getMataPelajaranListAdmin
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> updateMataPelajaran(MataPelajaran newMataPelajaran) {
    // TODO: implement updateMataPelajaran
    throw UnimplementedError();
  }
}