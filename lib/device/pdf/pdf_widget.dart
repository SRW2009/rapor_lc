
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/device/pdf/pdf_global_setting.dart';

const pagePadding = const EdgeInsets.only(top: 70, bottom: 30, left: 40, right: 40);

TextStyle headerTextStyle({double size=14.0}) => TextStyle(
  fontBold: Font.ttf(PDFSetting.headerFontData),
  fontSize: size,
  fontWeight: FontWeight.bold,
);

TextStyle bodyTextStyle({double size=12.0}) => TextStyle(
  font: Font.ttf(PDFSetting.bodyFontData),
  fontSize: size,
);

Widget buildPageTitle(String title) => Text(
  title,
  textAlign: TextAlign.center,
  style: headerTextStyle(),
);

Widget buildPageNumber(int num) => Align(
  alignment: Alignment.centerRight,
  child: Container(
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(
        color: PdfColors.grey600,
      )),
    ),
    padding: const EdgeInsets.only(top: 5.0, left: 30.0),
    child: Text(
      'Halaman $num',
      style: headerTextStyle(),
    ),
  ),
);