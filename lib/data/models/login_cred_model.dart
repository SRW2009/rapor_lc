
import 'package:equatable/equatable.dart';
import 'package:rapor_lc/domain/entities/login_cred.dart';

class LoginCredentialsModel extends Equatable {
  LoginCredentialsModel({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  factory LoginCredentialsModel.fromJson(Map<String, dynamic> json) => LoginCredentialsModel(
    username: json['username'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };

  LoginCredentials toEntity() => LoginCredentials(
    username, password
  );

  @override
  List<Object?> get props => [username, password];
}