
import 'package:rapor_lc/domain/entities/abstract/user.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

mixin _SharedPrefsKey {
  final USER_NAME = 'user:name';
  final USER_EMAIL = 'user:email';
  final USER_STATUS = 'user:status';
  final USER_TOKEN = 'user:token';
  final USER_DIVISI_ID = 'user:div-id';
  final USER_DIVISI_NAME = 'user:div-name';
  final USER_DIVISI_ISLEADER = 'user:div-is-leader';
  final USER_DIVISI_BLOCK_ID = 'user:div-block-id';
  final USER_DIVISI_BLOCK_NAME = 'user:div-block-name';
}

abstract class _SharedPrefsMainFunction {
  Future<User?> get getCurrentUser;
  Future<bool> setCurrentUser(User user);
  Future<String?> get getToken;
  Future<bool> setToken(String token);
  Future<bool> logout();
}

class SharedPrefs with _SharedPrefsKey implements _SharedPrefsMainFunction {
  final Future<SharedPreferences> _sharedPreferences;

  // singleton
  static final SharedPrefs _instance = SharedPrefs._internal();
  SharedPrefs._internal()
      : _sharedPreferences = SharedPreferences.getInstance();
  factory SharedPrefs() => _instance;

  User? _currentUser;
  String? _token;

  @override
  Future<User?> get getCurrentUser async {
    if (_currentUser != null) return _currentUser!;

    final pref = await _sharedPreferences;
    final name = pref.getString(USER_NAME);
    final email = pref.getString(USER_EMAIL);
    final status = pref.getInt(USER_STATUS);

    if (name == null || email == null || status == null) {
      return null;
    }

    User? user;
    if (status == 1) {
      final divId = pref.getInt(USER_DIVISI_ID)!;
      final divName = pref.getString(USER_DIVISI_NAME)!;
      final divIsLeader = pref.getBool(USER_DIVISI_ISLEADER)!;

      final divBlockId = await pref.getInt(USER_DIVISI_BLOCK_ID);
      final divBlockName = await pref.getString(USER_DIVISI_BLOCK_NAME);
      bool divBlockExist = divBlockId != null && divBlockName != null;

      user = Teacher(0, name,
        email: email,
        isLeader: divIsLeader,
        divisi: Divisi(divId, divName, false),
        divisiBlock: (divBlockExist) ? Divisi(divBlockId, divBlockName, true) : null,
      );
    } else if (status == 2) {
      user = Admin(0, name, email: email);
    }

    _currentUser = user;
    return user;
  }

  @override
  Future<bool> setCurrentUser(User user) async {
    final pref = await _sharedPreferences;
    final name = await pref.setString(USER_NAME, user.name);
    final email = await pref.setString(USER_EMAIL, user.email!);
    final status = await pref.setInt(USER_STATUS, user.status);

    if (user is Teacher) {
      final divId = await pref.setInt(USER_DIVISI_ID, user.divisi.id);
      final divName = await pref.setString(USER_DIVISI_NAME, user.divisi.name);
      final divIsLeader = await pref.setBool(USER_DIVISI_ISLEADER, user.isLeader!);

      if (!divId || !divName || !divIsLeader) {
        return false;
      }

      final divBlock = user.divisiBlock;
      if (divBlock != null) {
        final divBlockId = await pref.setInt(USER_DIVISI_BLOCK_ID, divBlock.id);
        final divBlockName = await pref.setString(USER_DIVISI_BLOCK_NAME, divBlock.name);

        if (!divBlockId || !divBlockName) {
          return false;
        }
      }
    }

    if (name && email && status) {
      _currentUser = user;
      return true;
    }

    return false;
  }

  @override
  Future<String?> get getToken async {
    if (_token != null) return _token!;

    final pref = await _sharedPreferences;
    final token = pref.getString(USER_TOKEN);

    _token = token;
    return token;
  }

  @override
  Future<bool> setToken(String token) async {
    final pref = await _sharedPreferences;
    final setSuccess = await pref.setString(USER_TOKEN, token);

    if (setSuccess) {
      _token = token;
      return true;
    }

    return false;
  }

  @override
  Future<bool> logout() async {
    final pref = await _sharedPreferences;
    final success = await pref.clear();

    if (success) {
      _currentUser = null;
    }

    return success;
  }
}