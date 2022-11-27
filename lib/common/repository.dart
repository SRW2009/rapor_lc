
import 'package:rapor_lc/data/helpers/shared_prefs.dart';
import 'package:rapor_lc/domain/entities/abstract/user.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

abstract class Repository {
  String url = '';
  String altUrl = '';

  bool privChecked = false;
  User? repUser;

  Future<void> checkPrivilege() async {
    if (!privChecked) {
      final user = await SharedPrefs().getCurrentUser;
      if (user == null) throw Exception();
      if (user is Teacher) url = altUrl;
      privChecked = true;
      repUser = user;
    }
  }

  Uri readUri() => Uri.parse(url.substring(0, url.length-1));
  Uri createUri() => Uri.parse(url);
  Uri updateUri(int id) => Uri.parse('$url$id');
  Uri deleteUri(String id) => Uri.parse('$url$id');
}