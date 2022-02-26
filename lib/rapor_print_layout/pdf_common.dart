
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Text timesText(String text) => Text(
text, style: TextStyle(font: Font.times(), fontSize: 12.0),
);

Widget buildPageTitle(String title) => Text(
  title,
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: 18.0,
    font: Font.times(),
  ),
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
    child: timesText(
      'Halaman $num',
    ),
  ),
);