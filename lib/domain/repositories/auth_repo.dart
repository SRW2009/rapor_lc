
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/abstract/user.dart';
import 'package:rapor_lc/common/repository.dart';

abstract class AuthenticationRepository extends Repository {
  /// Authenticates teacher as teacher using his [email] and [password]
  Future<int> authenticateTeacher(
      {required String email, required String password});

  /// Authenticates teacher as admin using his [email] and [password]
  Future<int> authenticateAdmin(
      {required String email, required String password});

  /// Returns whether the teacher is authenticated.
  Future<int> isAuthenticated();

  /// Returns the current authenticated teacher.
  Future<User?> getCurrentUser();

  /// Returns the current authenticated teacher's token.
  Future<String?> getCurrentToken();

  /// Resets the password of a teacher
  Future<bool> forgotPassword(String email);

  /// Logs out the teacher
  Future<bool> logout();
}
