
import 'package:json_annotation/json_annotation.dart';

enum Month { Juli, Agustus, September, Oktober, November, Desember,
  Januari, Februari, Maret, April, Mei, Juni }

enum SemesterInRoman { I, II, III, IV, V, VI }

enum SemesterAsText { Satu, Dua, Tiga, Empat, Lima, Enam }

@JsonSerializable(createFactory: false, createToJson: false)
class BulanAndSemester {
  int bulan;
  int semester;

  BulanAndSemester(this.bulan, this.semester);

  factory BulanAndSemester.fromString(String initial) {
    final list = initial.split('-');
    int? bulan = int.tryParse(list[0]);
    int? semester;
    if (list[1].startsWith('s')) semester = int.tryParse(list[1].substring(1));
    if (bulan != null && semester != null) return BulanAndSemester(bulan, semester);
    throw const FormatException('Bad String format.');
  }

  @override
  String toString() => '$bulan-s$semester';

  String toReadableString() => '${bulanToString()}, Semester ${semesterToString()}';

  String bulanToString() => Month.values[bulan-1].name;

  String semesterToString() => '${SemesterAsText.values[semester-1].name} (${SemesterInRoman.values[semester-1].name})';

  int compareTo(BulanAndSemester otherBaS) {
    final thisVal = double.tryParse('$bulan.$semester') ?? 0;
    final otherVal = double.tryParse('${otherBaS.bulan}.${otherBaS.semester}') ?? 0;
    return thisVal.compareTo(otherVal);
  }
}

class BaSConverter implements JsonConverter<BulanAndSemester, String> {
  const BaSConverter();

  @override
  BulanAndSemester fromJson(String json) => BulanAndSemester.fromString(json);

  @override
  String toJson(BulanAndSemester object) => object.toString();
}