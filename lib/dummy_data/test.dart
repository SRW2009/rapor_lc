
abstract class File {
  abstract String fileName;
}

abstract class Image {
  abstract DateTime dateCaptured;
}

abstract class Video {
  abstract Duration duration;
}

class Screenshot extends Image {
  Screenshot(this.screenshotName, this.dateCaptured);

  final String screenshotName;

  @override
  DateTime dateCaptured;
}

class Photo extends Image {
  Photo(this.photoName, this.dateCaptured);

  final String photoName;

  @override
  DateTime dateCaptured;
}

class Movie extends Video {
  Movie(this.movieName, this.duration);

  final String movieName;

  @override
  Duration duration;
}



abstract class Req<A> {
  Req(this.url);

  final String url;

  List<A> readData(String query);
  String createData(A file);
  String updateData(int id, A newFile);
  String deleteData(int id);
}

class Request<A> extends Req<A> {
  Request(String url) : super(url);

  @override
  String createData(A file) => throw UnimplementedError();

  @override
  String deleteData(int id) => throw UnimplementedError();

  @override
  List<A> readData(String query) => throw UnimplementedError();

  @override
  String updateData(int id, A newFile) => throw UnimplementedError();
}

class ImageRequest<A extends Image> extends Req<A> {
  ImageRequest(String url) : super(url);

  @override
  String createData(A file) => throw UnimplementedError();

  @override
  String deleteData(int id) => throw UnimplementedError();

  @override
  List<A> readData(String query) => throw UnimplementedError();

  @override
  String updateData(int id, A newFile) => throw UnimplementedError();

}

class MovieRequest extends Req<Movie> {
  MovieRequest(String url) : super(url);

  @override
  String createData(Movie file) => throw UnimplementedError();

  @override
  String deleteData(int id) => throw UnimplementedError();

  @override
  List<Movie> readData(String query) => throw UnimplementedError();

  @override
  String updateData(int id, Movie newFile) => throw UnimplementedError();
}

main() {
  var req = Request<File>('www.file.com');
  List<File> files = req.readData('SELECT * FROM ...');
  var req2 = Request<Photo>('www.photo.com');
  List<Photo> photos = req2.readData('SELECT * FROM ...');

  var imageReq = ImageRequest('www.image.com');
  List<Image> images = imageReq.readData('SELECT * FROM ...');
  var screenshotReq = ImageRequest<Screenshot>('ww.screenshot.com');
  List<Screenshot> screenshots = screenshotReq.readData('SELECT * FROM ...');

  var movieReq = MovieRequest('www.movie.com');
  List<Movie> movies = movieReq.readData('SELECT * FROM ...');
}

