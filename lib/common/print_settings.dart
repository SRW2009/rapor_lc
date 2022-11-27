
import 'package:rapor_lc/domain/entities/timeline.dart';

class PrintSettings {
  final String imageAssetPath;
  late final int fromTimelineInt;
  late final int toTimelineInt;
  final bool nhbSemesterPage;
  final bool nhbBlockPage;
  final bool npbPage;
  final bool nkPage;
  final bool nkAdvicePage;

  PrintSettings(this.imageAssetPath, Timeline fromT, Timeline toT, {
    this.nhbSemesterPage=true, this.npbPage=true, this.nhbBlockPage=true, this.nkPage=true, this.nkAdvicePage=true,
  }) {
    fromT.bulan = (fromT.semester==2) ? 7 : 1;
    this.fromTimelineInt = fromT.toInt();
    toT.bulan = (toT.semester==2) ? 12 : 6;
    this.toTimelineInt = toT.toInt();
  }
}