
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

class TeacherModel {
  static Teacher fromJsonToEntity(Map<String, dynamic> e) => Teacher(
    e['id'],
    e['name'],
    email: e['email'],
    password: e['password'],
    isLeader: e['is_leader'],
    divisi: Divisi.fromJson(e['divisi_detail']),
  );
  static Map<String, dynamic> fromEntityToJson(Teacher e)  => {
    "name": e.name,
    "email": e.email,
    "password": e.password,
    "is_leader": e.isLeader,
    "divisi_id": e.divisi?.id
  };
}