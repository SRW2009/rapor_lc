
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/repositories/admin_repo.dart';
import 'package:rapor_lc/dummy_data/dummies.dart' as d;

class AdminRepositoryImplTest extends AdminRepository {
  final List<Admin> adminList;

  // singleton
  AdminRepositoryImplTest._internal()
      : adminList = [...d.adminList];
  static final AdminRepositoryImplTest _instance = AdminRepositoryImplTest._internal();
  factory AdminRepositoryImplTest() => _instance;

  @override
  Future<RequestStatus> createAdmin(Admin user) =>
      Future.delayed(DataConstant.test_duration, () async {
        final item = Admin.fromJson(user.toJson()..['id']=adminList.length);
        adminList.add(item);
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<RequestStatus> deleteAdmin(List<String> ids) async =>
      Future.delayed(DataConstant.test_duration, () async {
        adminList.removeWhere((element) => ids.contains(element.id.toString()));
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<List<Admin>> getAdminList() async =>
      Future.delayed(DataConstant.test_duration, () async {
        return adminList;
        //failed
        throw Exception();
      });

  @override
  Future<RequestStatus> updateAdmin(Admin user) async =>
      Future.delayed(DataConstant.test_duration, () async {
        final index = adminList.indexOf(user);
        adminList.replaceRange(
          index, index+1, [user]
        );
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });
}