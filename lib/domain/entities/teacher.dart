
import 'package:json_annotation/json_annotation.dart';
import 'package:rapor_lc/domain/entities/abstract/user.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher extends User {
  final int id;
  @JsonKey(name: 'is_leader')
  final bool? isLeader;
  @JsonKey(name: 'divisi_detail')
  final Divisi divisi;
  @JsonKey(name: 'divisi_block_detail')
  final Divisi? divisiBlock;

  Teacher(this.id, String name, {String? email, String? password, this.isLeader, required this.divisi, this.divisiBlock})
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