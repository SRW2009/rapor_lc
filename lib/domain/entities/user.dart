
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String email;
  final String password;
  final int status;

  User(this.email, this.password, {this.status=0});

  User.teacher(this.email, this.password) : status = 1;

  User.admin(this.email, this.password) : status = 2;

  String get getStatusName {
    switch (status) {
      case 1:
        return 'Teacher';
      case 2:
        return 'Admin';
      default:
        return '';
    }
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class UserConverter implements JsonConverter<User, Map<String, dynamic>> {
  const UserConverter();

  @override
  User fromJson(Map<String, dynamic> json) => User.fromJson(json);

  @override
  Map<String, dynamic> toJson(User object) => object.toJson();
}