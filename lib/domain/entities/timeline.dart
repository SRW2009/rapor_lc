
import 'package:json_annotation/json_annotation.dart';

enum Bulan { Juli, Agustus, September, Oktober, November, Desember,
  Januari, Februari, Maret, April, Mei, Juni }

enum NumberInRoman { I, II, III, IV, V, VI, VII, VIII, IX, X }

enum NumberConsonant { Satu, Dua, Tiga, Empat, Lima, Enam, Tujuh, Delapan, Sembilan }

@JsonSerializable(createFactory: false, createToJson: false)
class Timeline implements Comparable {
  static const int INT_MIN = 1;
  static const int INT_MAX = 72;

  int bulan;
  int semester;
  int kelas;
  int level;

  Timeline(this.bulan, this.semester, this.kelas, this.level);

  Timeline.initial() : bulan=1,semester=1,kelas=1,level=1;

  factory Timeline.fromString(String initial) {
    int? bulan, semester, kelas, level;

    /// default format : [bulan]-s[semester]-k[kelas]-l[level] | 1-s1-k2-l1
    final strings = initial.split('-');
    if (strings.length == 4) {
      bulan = int.tryParse(strings[0]);
      if (strings[1].startsWith('s')) semester = int.tryParse(strings[1].substring(1));
      if (strings[2].startsWith('k')) kelas = int.tryParse(strings[2].substring(1));
      if (strings[3].startsWith('l')) level = int.tryParse(strings[3].substring(1));
      if (bulan!=null && semester!=null && kelas!=null && level!=null) {
        return Timeline(bulan, semester, kelas, level);
      }
    }

    // excel format : [bulan name], Semester [semester], Kelas [kelas], Level [level] | Juli, Semester 1, Kelas 1, Level 1
    final strings2 = initial.split(',');
    if (strings2.length == 4) {
      for (var month in Bulan.values) {
        if (month.name == strings2[0]) {
          bulan = month.index+1;
          break;
        }
      }
      semester = int.tryParse(strings2[1].replaceAll('Semester', '').replaceAll(' ', ''));
      kelas = int.tryParse(strings2[2].replaceAll('Kelas', '').replaceAll(' ', ''));
      level = int.tryParse(strings2[3].replaceAll('Level', '').replaceAll(' ', ''));
      if (bulan!=null && semester!=null && kelas!=null && level!=null) {
        return Timeline(bulan, semester, kelas, level);
      }
    }
    throw const FormatException('Bad String format.');
  }

  @override
  String toString() => '$bulan-s$semester-k$kelas-l$level';

  factory Timeline.fromInt(int v) {
    if (v < INT_MIN || v > INT_MAX) throw RangeError.range(v, INT_MIN, INT_MAX);
    final bulanRange = 6;
    var bulan = ((v-1) % bulanRange) + 1;
    final semester = (((v-1)/bulanRange).truncate() % semesterRange.length) + 1;
    if (semester == 2) bulan += bulanRange;
    final kelas = (((v-1)/bulanRange/semesterRange.length).truncate() % kelasRange.length) + 1;
    final level = (((v-1)/bulanRange/semesterRange.length/kelasRange.length).truncate() % levelRange.length) + 1;
    return Timeline(bulan, semester, kelas, level);
  }

  int toInt() {
    final level = bulanRange.length*kelasRange.length*(this.level-1);
    final kelas = bulanRange.length*(this.kelas-1);
    return this.bulan+kelas+level;
  }

  String toExcelString() => '$bulanReadable, Semester $semester, Kelas $kelas, Level $level';

  String bulanFormatted() {
    var str = '$bulan';
    if (str.length == 1) return '0$bulan';
    return '$bulan';
  }

  String get bulanReadable => Bulan.values[bulan-1].name;
  String get semesterReadable => '${NumberConsonant.values[semester-1].name} (${NumberInRoman.values[semester-1].name})';
  String get kelasReadable => '${NumberConsonant.values[kelas-1].name} (${NumberInRoman.values[kelas-1].name})';
  String get levelReadable => '${NumberConsonant.values[level-1].name} (${NumberInRoman.values[level-1].name})';

  static List<int> get bulanRange => [1,2,3,4,5,6,7,8,9,10,11,12];
  static List<int> get semesterRange => [1,2];
  static List<int> get kelasRange => [1,2,3];
  static List<int> get levelRange => [1,2];

  @override
  int compareTo(other) {
    if (other is! Timeline) throw TypeError();
    final thisVal = double.tryParse('$level.$kelas$semester${bulanFormatted()}') ?? 0;
    final otherVal = double.tryParse('${other.level}.${other.kelas}${other.semester}${other.bulanFormatted()}') ?? 0;
    return thisVal.compareTo(otherVal);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Timeline &&
          runtimeType == other.runtimeType &&
          bulan == other.bulan &&
          semester == other.semester &&
          kelas == other.kelas &&
          level == other.level;

  @override
  int get hashCode => bulan.hashCode ^ semester.hashCode ^ kelas.hashCode ^ level.hashCode;

  bool isTimelineMatch(Timeline other) {
    return semester == other.semester &&
        kelas == other.kelas &&
        level == other.level;
  }
}

class TimelineConverter implements JsonConverter<Timeline, String> {
  const TimelineConverter();

  @override
  Timeline fromJson(String json) => Timeline.fromString(json);

  @override
  String toJson(Timeline object) => object.toString();
}