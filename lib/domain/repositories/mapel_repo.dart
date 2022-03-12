
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/common/repository.dart';

abstract class MataPelajaranRepository extends Repository {
  Future<List<MataPelajaran>> getMataPelajaranList();
  Future<MataPelajaran> getMataPelajaran(int id);
  Future<RequestStatus> createMataPelajaran(MataPelajaran nhb);
  Future<RequestStatus> updateMataPelajaran(MataPelajaran newMataPelajaran);
  Future<RequestStatus> deleteMataPelajaran(List<String> ids);
}