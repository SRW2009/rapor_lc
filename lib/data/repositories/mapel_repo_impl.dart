
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/repositories/mapel_repo.dart';
import 'package:rapor_lc/dummy_data/mata_pelajaran.dart';

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
  Future<List<MataPelajaran>> getMataPelajaranList() async {
    // TODO: implement getMataPelajaranList
    await Future.delayed(const Duration(seconds: 3));
    return pelajaranList;
  }

  @override
  Future<RequestStatus> updateMataPelajaran(MataPelajaran newMataPelajaran) {
    // TODO: implement updateMataPelajaran
    throw UnimplementedError();
  }
}