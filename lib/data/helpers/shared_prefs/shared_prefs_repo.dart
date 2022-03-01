
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rapor_lc/domain/entities/user.dart';

class SharedPrefsRepository {
  static const _USER_EMAIL = 'user:email';
  static const _USER_STATUS = 'user:status';

  final Future<SharedPreferences> _sharedPreferences;

  // singleton
  static final SharedPrefsRepository _instance = SharedPrefsRepository._internal();
  SharedPrefsRepository._internal()
      : _sharedPreferences = SharedPreferences.getInstance();
  factory SharedPrefsRepository() => _instance;

  User? _currentUser;
  int? _loginPrivilege;

  Future<User?> get getCurrentUser async {
    if (_currentUser != null) return _currentUser!;

    final pref = await _sharedPreferences;
    final email = pref.getString(_USER_EMAIL);
    final status = pref.getInt(_USER_STATUS);

    if (email == null || status == null) {
      return null;
    }

    User? user;
    if (status == 1) {
      user = User.teacher(email, '');
    } else if (status == 2) {
      user = User.admin(email, '');
    }

    _currentUser = user;
    return user;
  }

  Future<bool> setCurrentUser(User user) async {
    final pref = await _sharedPreferences;
    final email = await pref.setString(_USER_EMAIL, user.email);
    final status = await pref.setInt(_USER_STATUS, user.status);

    if (email && status) {
      _currentUser = user;
      return true;
    }

    return false;
  }

  Future<int> get getLoginPrivilege async {
    if (_loginPrivilege != null) return _loginPrivilege!;

    final pref = await _sharedPreferences;
    final isLoggedIn = pref.getInt(_USER_STATUS);
    _loginPrivilege = isLoggedIn ?? 0;
    return _loginPrivilege!;
  }

  Future<bool> logout() async {
    final pref = await _sharedPreferences;
    final success = await pref.clear();

    if (success) {
      _currentUser = null;
      _loginPrivilege = 0;
    }

    return success;
  }
}