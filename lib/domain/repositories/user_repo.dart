
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

abstract class UserRepository extends Repository {
  Future<List<User>> getUserListAdmin([int status]);
  Future<User> getUserAdmin(String email);
  Future<RequestStatus> createUserAdmin(User user);
  Future<RequestStatus> updateUserAdmin(User user);
  Future<RequestStatus> deleteUserAdmin(String email);
}