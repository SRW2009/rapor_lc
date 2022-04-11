
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/abstract/user.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/auth_repo.dart';

class AuthenticationRepositoryImplTest extends AuthenticationRepository {
  static const _testToken = 'tokenize-123';

  @override
  Future<int> authenticateTeacher({required String email, required String password}) {
    return Future.delayed(DataConstant.test_duration, () async {
      final user = Teacher(0, 'Guruku', email: email, isLeader: false, divisi: null);
      await SharedPrefsRepository().setCurrentUser(user);
      await SharedPrefsRepository().setToken(_testToken);

      return user.status;
      // failed
      return 0;
    });
  }

  @override
  Future<int> authenticateAdmin({required String email, required String password}) async =>
      Future.delayed(DataConstant.test_duration, () async {
        final user = Admin(0, 'Adminku', email: email);
        await SharedPrefsRepository().setCurrentUser(user);
        await SharedPrefsRepository().setToken(_testToken);

        return user.status;
        // failed
        return 0;
      });

  @override
  Future<bool> forgotPassword(String email) async {
    // TODO: implement forgotPassword
    await Future.delayed(const Duration(seconds: 3));
    return false;
  }

  @override
  Future<User?> getCurrentUser() async =>
      await SharedPrefsRepository().getCurrentUser;

  @override
  Future<String?> getCurrentToken() async =>
      await SharedPrefsRepository().getToken;

  @override
  Future<int> isAuthenticated() async =>
      await SharedPrefsRepository().getLoginPrivilege;

  @override
  Future<bool> logout() async =>
      await SharedPrefsRepository().logout();
}