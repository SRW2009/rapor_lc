
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(createFactory: false, createToJson: false)
abstract class User {
  final String name;
  final String? email;
  final String? password;

  User(this.name, {this.email, this.password});

  int get status;

  Map<String, dynamic> toJson();
}