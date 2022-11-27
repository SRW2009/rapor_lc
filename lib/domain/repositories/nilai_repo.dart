
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/common/repository.dart';

abstract class NilaiRepository extends Repository {
  Future<List<Nilai>> getNilaiList(int? studentId);
  Future<RequestStatus> createNilai(Nilai nilai);
  Future<RequestStatus> updateNilai(Nilai nilai);
  Future<RequestStatus> deleteNilai(List<String> ids);
}