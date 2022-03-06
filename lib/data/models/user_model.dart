
import 'package:equatable/equatable.dart';
import 'package:rapor_lc/domain/entities/user.dart';

class UserModel extends Equatable {
  UserModel({
    required this.email, 
    required this.password, 
    required this.status,
  });
  
  final String email;
  final String password;
  final int status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json['email'],
    password: json['password'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'status': status,
  };
  
  User toEntity() => User(email, password, status: status);

  @override
  List<Object?> get props => [email, password, status];
}