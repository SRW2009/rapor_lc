
class Urls {
  static const _hostUrl = 'http://localhost:8080';//'http://10.50.50.2:1421';
  static const loginTeacherUrl = '$_hostUrl/v1/login';
  static const loginAdminUrl = '$_hostUrl/v1/login-admin-col';
}

class DataConstant {
  static const test_duration = Duration(seconds: 2);
  static const queryType_get = 0;
  static const queryType_action = 1;
  static headers([String? token]) => <String, String> {
    'Content-Type': 'application/json; charset=UTF-8',
    if (token != null) 'Authorization': 'Bearer $token',
  };
}

class StatusCode {
  static const getSuccess = 200;
  static const postSuccess = 201;
}