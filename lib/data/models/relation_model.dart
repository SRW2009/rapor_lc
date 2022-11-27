
import 'package:rapor_lc/data/models/teacher_model.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class RelationModel {
  static Relation fromJsonRequest(Map<String, dynamic> json) => Relation(
    json['id'] as int,
    TeacherModel.fromJsonRelationRequest(json['teacher']),
    Santri.fromJson(json['student'] as Map<String, dynamic>),
    name: json['name'] as String?,
    isActive: json['is_active'] as bool? ?? false,
  );
  static Map<String, dynamic> toJsonRequest(Relation e)  => {
    'teacher_id': e.teacher.id,
    'student_id': e.santri.id,
    'name': '${e.name}',
    'is_active': e.isActive
  };
}