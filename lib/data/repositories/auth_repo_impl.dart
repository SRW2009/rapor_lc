
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/repositories/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final SharedPrefsRepository _sharedPrefsRepository;

  //singleton
  static final AuthenticationRepositoryImpl _instance = AuthenticationRepositoryImpl._internal();
  AuthenticationRepositoryImpl._internal()
      : _sharedPrefsRepository = SharedPrefsRepository();
  factory AuthenticationRepositoryImpl() => _instance;

  @override
  Future<bool> authenticate({required String email, required String password}) async {
    // TODO: implement forgotPassword
    await Future.delayed(const Duration(seconds: 3));
    await _sharedPrefsRepository.setCurrentUser(
      User.admin(email, password)
    );
    return true;
  }

  @override
  Future<bool> forgotPassword(String email) async {
    // TODO: implement forgotPassword
    await Future.delayed(const Duration(seconds: 3));
    return false;
  }

  @override
  Future<User> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isAuthenticated() {
    // TODO: implement isAuthenticated
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}