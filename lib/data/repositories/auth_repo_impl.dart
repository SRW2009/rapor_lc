
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/repositories/auth_repo.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {

  //singleton
  static final AuthenticationRepositoryImpl _instance = AuthenticationRepositoryImpl._internal();
  AuthenticationRepositoryImpl._internal();
  factory AuthenticationRepositoryImpl() => _instance;

  @override
  Future<bool> authenticate({required String email, required String password}) {
    // TODO: implement authenticate
    throw UnimplementedError();
  }

  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
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
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}