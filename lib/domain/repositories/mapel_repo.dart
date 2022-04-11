
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/common/repository.dart';

abstract class MataPelajaranRepository extends Repository {
  Future<List<MataPelajaran>> getMataPelajaranList();
  Future<List<MataPelajaran>> getNKVariables();
  Future<RequestStatus> createMataPelajaran(MataPelajaran nhb);
  Future<RequestStatus> updateMataPelajaran(MataPelajaran newMataPelajaran);
  Future<RequestStatus> deleteMataPelajaran(List<String> ids);
}