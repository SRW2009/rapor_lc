
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/common/repository.dart';

abstract class NPBRepository extends Repository {
  Future<List<NPB>> getNPBListAdmin();
  Future<List<NPB>> getNPBList(String santriNis);
  Future<NPB> getNPB(int id);
  Future<RequestStatus> createNPB(NPB npb);
  Future<RequestStatus> updateNPB(NPB npb);
  Future<RequestStatus> deleteNPB(List<String> ids);
}