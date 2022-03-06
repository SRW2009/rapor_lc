
import 'package:fl_chart/fl_chart.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

abstract class NKRepository extends Repository {
  Future<List<NK>> getNKListAdmin();
  Future<List<NK>> getNKList(String santriNis);
  Future<NK> getNK(int id);
  Future<RequestStatus> createNK(NK nk);
  Future<RequestStatus> updateNK(NK newNK);
  Future<RequestStatus> deleteNK(List<String> ids);
}