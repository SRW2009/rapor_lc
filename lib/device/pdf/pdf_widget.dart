
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/device/pdf/pdf_global_setting.dart';

const pagePadding = const EdgeInsets.only(
  top: 70,
  bottom: 70,
  left: 85,
  right: 70,
);

const font14pt = 14.0;
const font12pt = 12.0;
const font10pt = 10.0;

TextStyle headerTextStyle({double size=font14pt}) => TextStyle(
  fontBold: Font.ttf(PDFSetting.headerFontData),
  fontSize: size,
  fontWeight: FontWeight.bold,
);

TextStyle bodyTextStyle({double size=font12pt}) => TextStyle(
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