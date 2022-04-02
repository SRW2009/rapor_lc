
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/common/repository.dart';

abstract class AdminRepository extends Repository {
  Future<List<Admin>> getAdminList();
  Future<RequestStatus> createAdmin(Admin user);
  Future<RequestStatus> updateAdmin(Admin user);
  Future<RequestStatus> deleteAdmin(List<String> ids);
}