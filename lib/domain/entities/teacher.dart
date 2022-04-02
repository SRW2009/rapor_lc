

import 'package:json_annotation/json_annotation.dart';
import 'package:rapor_lc/domain/entities/abstract/user.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';

part 'teacher.g.dart';

@JsonSerializable()
@NullableDivisiConverter()
class Teacher extends User {
  final int id;
  @JsonKey(name: 'is_leader')
  final bool? isLeader;
  final Divisi? divisi;

  Teacher(this.id, String name, {String? email, String? password, this.isLeader, this.divisi})
      : super(name, email: email, password: password);

  factory Teacher.fromJson(Map<String, dynamic> json) => _$TeacherFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TeacherToJson(this);

  @override
  int get status => 1;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Teacher &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class TeacherConverter implements JsonConverter<Teacher, Map<String, dynamic>> {
  const TeacherConverter();

  @override
  Teacher fromJson(Map<String, dynamic> json) => Teacher.fromJson(json);

  @override
  Map<String, dynamic> toJson(Teacher object) => object.toJson();
}