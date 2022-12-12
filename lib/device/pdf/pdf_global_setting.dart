
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';

class PDFSetting {
  static const defaultColorsGroup = [
    PdfColors.blue, PdfColors.orange, /*green*/ PdfColor.fromInt(0x0CA39B), PdfColors.yellow, PdfColors.green,
    PdfColors.red, PdfColors.black, PdfColors.teal, PdfColors.brown, PdfColors.purple,
  ];
  static final nhbNormalSituationExistAt = [
    // semester 1, kelas 1, level 1
    Timeline(1, 1, 1, 1),
    // semester 2, kelas 1, level 1
    //Timeline(7, 2, 1, 1),
  ];

  static int npbMaxRow = 24;

  static late ByteData headerFontData;
  static late ByteData bodyFontData;
}