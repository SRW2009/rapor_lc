
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

class TeacherModel {
  static Teacher fromJsonLoginRequest(Map<String, dynamic> json) => Teacher(
    json['id'] as int,
    json['name'] as String,
    email: json['email'] as String?,
    isLeader: json['is_leader'] as bool?,
    divisi: Divisi.fromJson(json['divisi'] as Map<String, dynamic>),
    divisiBlock: json['divisi_block'] == null
        ? null
        : Divisi.fromJson(json['divisi_block'] as Map<String, dynamic>),
  );
  static Teacher fromJsonRelationRequest(Map<String, dynamic> json) => Teacher(
    json['id'] as int,
    json['name'] as String,
    divisi: Divisi(0,'',false),
  );
  static Map<String, dynamic> toJsonRequest(Teacher e)  => {
    "name": e.name,
    "email": e.email,
    "password": e.password,
    "is_leader": e.isLeader,
    "divisi_id": e.divisi.id,
    "divisi_block_id": e.divisiBlock?.id
  };
}