
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/common/repository.dart';

abstract class SantriRepository extends Repository {
  Future<List<Santri>> getSantriListAdmin();
  Future<List<Santri>> getSantriList(User guru);
  Future<Santri> getSantri(String nis);
  Future<RequestStatus> createSantri(Santri santri);
  Future<RequestStatus> updateSantri(Santri santri);
  Future<RequestStatus> deleteSantri(List<String> nisList);
}