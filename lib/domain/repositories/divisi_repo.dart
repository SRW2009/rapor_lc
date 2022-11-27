
import 'package:rapor_lc/common/repository.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';

abstract class DivisiRepository extends Repository {
  Future<List<Divisi>> getDivisiList();
  Future<RequestStatus> createDivisi(Divisi divisi);
  Future<RequestStatus> updateDivisi(Divisi divisi);
  Future<RequestStatus> deleteDivisi(List<String> ids);
}