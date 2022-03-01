
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/repositories/auth_repo.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final SharedPrefsRepository _sharedPrefsRepository;

  //singleton
  static final AuthenticationRepositoryImpl _instance = AuthenticationRepositoryImpl._internal();
  AuthenticationRepositoryImpl._internal()
      : _sharedPrefsRepository = SharedPrefsRepository();
  factory AuthenticationRepositoryImpl() => _instance;

  @override
  Future<int> authenticate({required String email, required String password}) async {
    // TODO: implement authenticate
    await Future.delayed(const Duration(seconds: 3));

    final user = User.admin(email, password);
    await _sharedPrefsRepository.setCurrentUser(user);

    return user.status;
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
  Future<bool> isAuthenticated() async =>
      await _sharedPrefsRepository.getIsLoggedIn;

  @override
  Future<bool> logout() async =>
      await _sharedPrefsRepository.logout();
}