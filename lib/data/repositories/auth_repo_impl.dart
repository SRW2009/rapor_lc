
import 'dart:convert';

import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/repositories/auth_repo.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final SharedPrefsRepository _sharedPrefsRepository;

  //singleton
  static final AuthenticationRepositoryImpl _instance = AuthenticationRepositoryImpl._internal();
  AuthenticationRepositoryImpl._internal()
      : _sharedPrefsRepository = SharedPrefsRepository();
  factory AuthenticationRepositoryImpl() => _instance;

  @override
  Future<int> authenticate({required String email, required String password}) async {
    final response = await http.post(
      DataConstant.loginUri,
      headers: DataConstant.headers(),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == StatusCode.postSuccess) {
      final data = jsonDecode(response.body);
      final status = data['status'] as int;
      final token = data['token'];

      final user = User(email, password, status: status);
      await _sharedPrefsRepository.setCurrentUser(user);
      await _sharedPrefsRepository.setToken(token);

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
  Future<User> getCurrentUser() async {
    final user = await _sharedPrefsRepository.getCurrentUser;
    if (user == null) throw Exception();
    return user;
  }

  @override
  Future<String> getCurrentToken() async {
    final token = await _sharedPrefsRepository.getToken;
    if (token == null) throw Exception();
    return token;
  }

  @override
  Future<int> isAuthenticated() async =>
      await _sharedPrefsRepository.getLoginPrivilege;

  @override
  Future<bool> logout() async =>
      await _sharedPrefsRepository.logout();
}