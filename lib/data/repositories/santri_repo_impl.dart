
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/repositories/santri_repo.dart';

class SantriRepositoryImpl extends SantriRepository {
  @override
  Future<RequestStatus> createSantri(Santri santri) {
    // TODO: implement createSantri
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> deleteSantri(String santriNis) {
    // TODO: implement deleteSantri
    throw UnimplementedError();
  }

  @override
  Future<Santri> getSantri(String nis) {
    // TODO: implement getSantri
    throw UnimplementedError();
  }

  @override
  Future<List<Santri>> getSantriList(User guru) {
    // TODO: implement getSantriList
    throw UnimplementedError();
  }

  @override
  Future<List<Santri>> getSantriListAdmin() {
    // TODO: implement getSantriListAdmin
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> updateSantri(Santri newSantri) {
    // TODO: implement updateSantri
    throw UnimplementedError();
  }
}