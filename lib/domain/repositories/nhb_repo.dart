
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/common/repository.dart';

abstract class NHBRepository extends Repository {
  Future<List<NHB>> getNHBListAdmin();
  Future<List<NHB>> getNHBList(String santriNis);
  Future<NHB> getNHB(int id);
  Future<RequestStatus> createNHB(NHB nhb);
  Future<RequestStatus> updateNHB(NHB newNHB);
  Future<RequestStatus> deleteNHB(List<String> ids);
}