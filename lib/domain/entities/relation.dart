
import 'package:json_annotation/json_annotation.dart';
import 'package:rapor_lc/data/models/teacher_model.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

part 'relation.g.dart';

@JsonSerializable()
@_TeacherConverter()
class Relation {
  final int id;
  final Teacher teacher;
  @JsonKey(name: 'student')
  final Santri santri;
  final String? name;
  @JsonKey(name: 'is_active')
  final bool isActive;

  Relation(this.id, this.teacher, this.santri, {this.name, this.isActive=false});

  factory Relation.fromJson(json) => _$RelationFromJson(json);
  Map<String, dynamic> toJson() => _$RelationToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Relation &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class _TeacherConverter extends JsonConverter<Teacher, Map<String, dynamic>> {
  const _TeacherConverter();

  @override
  Teacher fromJson(Map<String, dynamic> json) {
    return TeacherModel.fromJsonRelationRequest(json);
  }

  @override
  Map<String, dynamic> toJson(Teacher object) {
    return TeacherModel.toJsonRequest(object);
  }

}