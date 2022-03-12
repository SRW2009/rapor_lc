
class DataConstant {
  static const _hostUrl = 'http://10.50.50.2:1421';
  static const loginUrl = '$_hostUrl/login.php';
  static const queryUrl = '$_hostUrl/query.php';
  static final queryUri = Uri.parse(queryUrl);
  static headers([String? token]) => <String, String> {
    'Content-Type': 'application/json; charset=UTF-8',
    if (token != null) 'Authorization': 'token $token',
  };
}

class StatusCode {
  static const getSuccess = 200;
  static const postSuccess = 201;
}