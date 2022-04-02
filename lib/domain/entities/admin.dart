
import 'package:rapor_lc/domain/entities/abstract/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin.g.dart';

@JsonSerializable()
class Admin extends User {
  final int id;

  Admin(this.id, String name, {String? email, String? password})
      : super(name, email: email, password: password);

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AdminToJson(this);

  @override
  int get status => 2;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Admin &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class AdminConverter implements JsonConverter<Admin, Map<String, dynamic>> {
  const AdminConverter();

  @override
  Admin fromJson(Map<String, dynamic> json) => Admin.fromJson(json);

  @override
  Map<String, dynamic> toJson(Admin object) => object.toJson();
}