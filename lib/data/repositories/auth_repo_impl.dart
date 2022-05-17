
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs.dart';
import 'package:rapor_lc/domain/entities/abstract/user.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/repositories/auth_repo.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  @override
  String get url => throw UnimplementedError();

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

    if (response.statusCode == StatusCode.getSuccess) {
      final data = jsonDecode(response.body)['data'];
      final token = data['token'];

      final user = Teacher.fromJson(data);
      await SharedPrefs().setCurrentUser(user);
      await SharedPrefs().setToken(token);

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

    if (response.statusCode == StatusCode.getSuccess) {
      final data = jsonDecode(response.body)['data'];
      final token = data['token'];

      final user = Admin.fromJson(data);
      await SharedPrefs().setCurrentUser(user);
      await SharedPrefs().setToken(token);

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
      await SharedPrefs().getCurrentUser;

  @override
  Future<String?> getCurrentToken() async =>
      await SharedPrefs().getToken;

  @override
  Future<int> isAuthenticated() async =>
      (await SharedPrefs().getCurrentUser)?.status ?? 0;

  @override
  Future<bool> logout() async =>
      await SharedPrefs().logout();
}