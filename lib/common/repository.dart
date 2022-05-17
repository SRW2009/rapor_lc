
abstract class Repository {
  String url = '';

  Uri readUri() => Uri.parse(url.substring(0, url.length-1));
  Uri createUri() => Uri.parse(url);
  Uri updateUri(int id) => Uri.parse('$url$id');
  Uri deleteUri(String id) => Uri.parse('$url$id');
}