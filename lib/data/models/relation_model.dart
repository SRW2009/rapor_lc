
import 'package:rapor_lc/domain/entities/relation.dart';

class RelationModel {
  static Map<String, dynamic> fromEntityToJson(Relation e)  => {
    'teacher_id': e.teacher.id,
    'student_id': e.santri.id,
    'name': e.name ?? '',
    'is_active': e.isActive
  };
}