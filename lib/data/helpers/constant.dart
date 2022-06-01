
class Urls {
  static const _hostUrl = 'https://raporsi.sekolahimpian.com';//'http://10.50.50.2:1421';
  static const loginAdminUrl = '$_hostUrl/v1/admin/login/';
  static const loginTeacherUrl = '$_hostUrl/v1/teacher/login/';

  // ADMIN
  static const adminTeacher = '$_hostUrl/v1/admin/teacher/';
  static const adminStudent = '$_hostUrl/v1/admin/student/';
  static const adminAdmin = '$_hostUrl/v1/admin/admin/';
  static const adminDivisi = '$_hostUrl/v1/admin/divisi/';
  static const adminMapel = '$_hostUrl/v1/admin/mapel/';
  static const adminRelation = '$_hostUrl/v1/admin/relation/';
  static const adminNilai = '$_hostUrl/v1/admin/nilai/';

  // TEACHER
  static const teacherGetStudent = '$_hostUrl/v1/teacher/student';
  static const teacherGetMapel = '$_hostUrl/v1/teacher/mapel';
  static const teacherGetNKVariables = '$_hostUrl/v1/teacher/nk';
  static const teacherNilai = '$_hostUrl/v1/teacher/nilai/';
}

class DataConstant {
  static const test_duration = Duration(seconds: 2);
  static headers([String? token]) => <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    if (token != null) 'Authorization': 'Bearer $token',
  };
}

class StatusCode {
  static const getSuccess = 200;
  static const postSuccess = 201;
  static const putSuccess = 200;
  static const deleteSuccess = 200;
}