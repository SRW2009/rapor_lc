
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

abstract class DivisiRepository extends Repository {
  Future<List<Divisi>> getDivisiList();
  Future<Divisi> getDivisi(int id);
  Future<RequestStatus> createDivisi(Divisi divisi);
  Future<RequestStatus> updateDivisi(Divisi divisi);
  Future<RequestStatus> deleteDivisi(List<String> ids);
}