
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/repositories/user_repo.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<RequestStatus> createUserAdmin(User user) {
    // TODO: implement createUserAdmin
    throw UnimplementedError();
  }

  @override
  Future<RequestStatus> deleteUserAdmin(List<String> email) {
    // TODO: implement deleteUserAdmin
    throw UnimplementedError();
  }

  @override
  Future<User> getUserAdmin(String email) {
    // TODO: implement getUserAdmin
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getUserListAdmin([int? status=-1]) async {
    // TODO: implement getUserListAdmin
    await Future.delayed(const Duration(seconds: 2));
    if (status == 1) {
      return List<User>
          .generate(5, (index) => User.teacher('email$index@mail.com','')).toList();
    }
    if (status == 2) {
      return List<User>
          .generate(5, (index) => User.admin('email$index@mail.com','')).toList();
    }

    return List<User>
        .generate(5, (index) => (index % 1) == 0
        ? User.teacher('email$index@mail.com','')
        : User.admin('email$index@mail.com','')).toList();
  }

  @override
  Future<RequestStatus> updateUserAdmin(User user) {
    // TODO: implement updateUserAdmin
    throw UnimplementedError();
  }

}