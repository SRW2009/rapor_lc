
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

abstract class SantriRepository extends Repository {
  Future<List<Santri>> getSantriList();
  Future<Santri> getSantri(String nis);
  Future<RequestStatus> createSantri(Santri santri);
  Future<RequestStatus> updateSantri(Santri newSantri);
  Future<RequestStatus> deleteSantri(String santriNis);
}