
import 'package:pdf/pdf.dart';
import 'dart:io';

class PDFSetting {
  static const defaultColorsGroup = [
    PdfColors.blue, PdfColors.orange, /*green*/ PdfColor.fromInt(0x0CA39B), PdfColors.yellow, PdfColors.green,
    PdfColors.red, PdfColors.black, PdfColors.teal, PdfColors.brown, PdfColors.purple,
  ];
  static int npbMaxRow = 24;

  static late final headerFontData = File('fonts/carlito/Carlito-Bold.ttf').readAsBytesSync().buffer.asByteData();
  static late final bodyFontData = File('fonts/carlito/Carlito-Regular.ttf').readAsBytesSync().buffer.asByteData();
}