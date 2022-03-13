
class DataConstant {
  static const _hostUrl = 'http://localhost:8080';//'http://10.50.50.2:1421';
  static const loginUrl = '$_hostUrl/rapor_lc/login.php';
  static const getMd5Url = '$_hostUrl/rapor_lc/get_md5.php';
  static const queryUrl = '$_hostUrl/rapor_lc/query.php';
  static final loginUri = Uri.parse(loginUrl);
  static final getMd5Uri = Uri.parse(getMd5Url);
  static final queryUri = Uri.parse(queryUrl);
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