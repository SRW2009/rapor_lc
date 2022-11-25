
class PrintSettings {
  final String imageAssetPath;
  final int fromTimelineInt;
  final int toTimelineInt;
  final bool nhbSemesterPage;
  final bool nhbBlockPage;
  final bool npbPage;
  final bool nkPage;
  final bool nkAdvicePage;

  PrintSettings(this.imageAssetPath, this.fromTimelineInt, this.toTimelineInt, {
    this.nhbSemesterPage=true, this.npbPage=true, this.nhbBlockPage=true, this.nkPage=true, this.nkAdvicePage=true,
  });
}