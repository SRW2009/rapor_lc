
import 'dart:typed_data';

import 'package:pdf/pdf.dart';

class PDFSetting {
  static const defaultColorsGroup = [
    PdfColors.blue, PdfColors.orange, /*green*/ PdfColor.fromInt(0x0CA39B), PdfColors.yellow, PdfColors.green,
    PdfColors.red, PdfColors.black, PdfColors.teal, PdfColors.brown, PdfColors.purple,
  ];
  static int npbMaxRow = 24;

  static late ByteData headerFontData;
  static late ByteData bodyFontData;
}