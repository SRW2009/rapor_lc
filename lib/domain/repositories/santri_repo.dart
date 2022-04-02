
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/common/repository.dart';

abstract class SantriRepository extends Repository {
  Future<List<Santri>> getSantriList();
  Future<RequestStatus> createSantri(Santri santri);
  Future<RequestStatus> updateSantri(Santri santri);
  Future<RequestStatus> deleteSantri(List<String> nisList);
}