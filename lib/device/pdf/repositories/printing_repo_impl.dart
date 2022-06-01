
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rapor_lc/common/print_settings.dart';
import 'package:rapor_lc/device/pdf/pages/root.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repositories/printing_repo.dart';
import 'package:rapor_lc/dummy_data/dummies.dart' as d;

class PrintingRepositoryImpl extends PrintingRepository {
  Stream<String> print(List<Santri> selectedSantriList, List<Nilai> nilaiList, PrintSettings printSettings) async* {
    final headerImage = pw.MemoryImage(
      (await rootBundle.load(printSettings.imageAssetPath)).buffer.asUint8List(),
    );

    int errorCount = 0;
    final doc = pw.Document();
    for (var santri in selectedSantriList) {
      var santriNilaiList = nilaiList.where((element) => element.santri == santri).toList();
      if (santriNilaiList.length == 0) {
        yield '${santri.name} : Tidak ada record nilai.';
        errorCount++;
        continue;
      }
      for (var i = printSettings.fromSemester; i <= printSettings.toSemester; ++i) {
        try {
          doc.addPage(page_nhb(headerImage, santriNilaiList, semester: i));
        } catch (e) {
          yield '${santri.name} - Semester $i : Nilai NHB tidak lengkap.';
          errorCount++;
        }
        try {
          doc.addPage(page_npb_chart(headerImage, santriNilaiList, semester: i));
          doc.addPage(page_npb_table(headerImage, santriNilaiList, semester: i));
        } catch (e) {
          yield '${santri.name} - Semester $i : Nilai NPB Umum tidak lengkap.';
          errorCount++;
        }
        try {
          doc.addPage(page_npb_chart(headerImage, santriNilaiList, semester: i, isIT: true));
          doc.addPage(page_npb_table(headerImage, santriNilaiList, semester: i, isIT: true));
        } catch (e) {
          yield '${santri.name} - Semester $i : Nilai NPB IT tidak lengkap.';
          errorCount++;
        }
        try {
          doc.addPage(page_nk(headerImage, santriNilaiList, semester: i));
          doc.addPage(page_nk_advice(headerImage));
        } catch (e) {
          yield '${santri.name} - Semester $i : Nilai NK tidak lengkap.';
          errorCount++;
        }
      }
    }

    if (errorCount!=0) yield 'Terjadi $errorCount masalah saat memproses data. Print dibatalkan.';
    if (errorCount==0) {
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => doc.save());
    }
  }

  @override
  Future<void> printDummy() async {
    final headerImage = pw.MemoryImage(
        (await rootBundle.load('assets/images/rapor_header_qbs.png')).buffer.asUint8List(),
    );

    final doc = pw.Document();
    doc.addPage(page_title);
    doc.addPage(page_nhb(headerImage, [d.nilai_s_odd, d.nilai_s_even]));
    doc.addPage(page_npb_chart(headerImage, [d.nilai_s_odd, d.nilai_s_even]));
    doc.addPage(page_npb_table(headerImage, [d.nilai_s_odd, d.nilai_s_even]));
    doc.addPage(page_npb_chart(headerImage, [d.nilai_s_odd, d.nilai_s_even], isIT: true));
    doc.addPage(page_npb_table(headerImage, [d.nilai_s_odd, d.nilai_s_even], isIT: true));
    doc.addPage(page_nk(headerImage, [d.nilai_s_odd, d.nilai_s_even]));
    doc.addPage(page_nk_advice(headerImage));
    doc.addPage(page_nhb(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2));
    doc.addPage(page_npb_chart(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2));
    doc.addPage(page_npb_table(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2));
    doc.addPage(page_npb_chart(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2, isIT: true));
    doc.addPage(page_npb_table(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2, isIT: true));
    doc.addPage(page_nk(headerImage, [d.nilai_s_odd, d.nilai_s_even, d.nilai_s_even2, d.nilai_s_even3], semester: 2));
    doc.addPage(page_nk_advice(headerImage));

    await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => doc.save());
  }
}