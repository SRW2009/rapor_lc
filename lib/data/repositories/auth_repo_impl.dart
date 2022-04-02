
import 'dart:convert';

import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/abstract/user.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/auth_repo.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  @override
  Future<int> authenticateTeacher({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse(Urls.loginTeacherUrl),
      headers: DataConstant.headers(),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == StatusCode.postSuccess) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      final user = Teacher.fromJson(data);
      await SharedPrefsRepository().setCurrentUser(user);
      await SharedPrefsRepository().setToken(token);

      return user.status;
    }

    return 0;
  }

  @override
  Future<int> authenticateAdmin({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse(Urls.loginAdminUrl),
      headers: DataConstant.headers(),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == StatusCode.postSuccess) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      final user = Admin.fromJson(data);
      await SharedPrefsRepository().setCurrentUser(user);
      await SharedPrefsRepository().setToken(token);

      return user.status;
    }

    return 0;
  }

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