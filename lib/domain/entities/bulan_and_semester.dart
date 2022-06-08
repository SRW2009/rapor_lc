
import 'package:json_annotation/json_annotation.dart';

enum Month { Juli, Agustus, September, Oktober, November, Desember,
  Januari, Februari, Maret, April, Mei, Juni }

enum SemesterInRoman { I, II, III, IV, V, VI }

enum SemesterAsText { Satu, Dua, Tiga, Empat, Lima, Enam }

@JsonSerializable(createFactory: false, createToJson: false)
class BulanAndSemester implements Comparable {
  int bulan;
  int semester;

  BulanAndSemester(this.bulan, this.semester);

  factory BulanAndSemester.fromString(String initial) {
    int? bulan, semester;

    // default format : <Month Number>-s<Semester Number> | 1-s1
    final strings = initial.split('-');
    if (strings.length > 1) {
      bulan = int.tryParse(strings[0]);
      if (strings[1].startsWith('s')) semester = int.tryParse(strings[1].substring(1));
      if (bulan != null && semester != null) return BulanAndSemester(bulan, semester);
    }

    // excel format : <Month Name>, Semester <Semester Number> | Juli, Semester 1
    final strings2 = initial.split(',');
    if (strings2.length > 1) {
      for (var month in Month.values) {
        if (month.name == strings2[0]) {
          bulan = month.index+1;
          break;
        }
      }
      semester = int.tryParse(strings2[1].replaceAll('Semester', '').replaceAll(' ', ''));
      if (bulan != null && semester != null) return BulanAndSemester(bulan, semester);
    }
    throw const FormatException('Bad String format.');
  }

  @override
  String toString() => '$bulan-s$semester';

  String toReadableString() => '${bulanToString()}, Semester ${semesterToString()}';

  String bulanToString() => Month.values[bulan-1].name;

  String bulanFormatted() {
    var str = '$bulan';
    if (str.length == 1) return '0$bulan';
    return '$bulan';
  }

  String semesterToString() => '${SemesterAsText.values[semester-1].name} (${SemesterInRoman.values[semester-1].name})';

  @override
  int compareTo(other) {
    if (other is! BulanAndSemester) throw TypeError();
    final thisVal = double.tryParse('$semester.${bulanFormatted()}') ?? 0;
    final otherVal = double.tryParse('${other.semester}.${other.bulanFormatted()}') ?? 0;
    return thisVal.compareTo(otherVal);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BulanAndSemester &&
          runtimeType == other.runtimeType &&
          bulan == other.bulan &&
          semester == other.semester;

  @override
  int get hashCode => bulan.hashCode ^ semester.hashCode;
}

class BaSConverter implements JsonConverter<BulanAndSemester, String> {
  const BaSConverter();

  @override
  BulanAndSemester fromJson(String json) => BulanAndSemester.fromString(json);

  @override
  String toJson(BulanAndSemester object) => object.toString();
}