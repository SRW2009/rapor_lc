
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rapor_lc/common/print_settings.dart';
import 'package:rapor_lc/device/pdf/pages/page_nhb_block.dart';
import 'package:rapor_lc/device/pdf/pages/root.dart';
import 'package:rapor_lc/device/pdf/pdf_data_factory.dart';
import 'package:rapor_lc/device/pdf/pdf_global_setting.dart';
import 'package:rapor_lc/device/pdf/pdf_object.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';
import 'package:rapor_lc/domain/repositories/printing_repo.dart';
import 'package:rapor_lc/dummy_data/dummies.dart' as d;

class PrintingRepositoryImpl extends PrintingRepository {

  Stream<String> print(List<Santri> selectedSantriList, List<Nilai> nilaiList, PrintSettings printSettings) async* {
    final headerImage = pw.MemoryImage((await rootBundle.load(printSettings.imageAssetPath)).buffer.asUint8List());
    try {
      PDFSetting.headerFontData.toString();
      PDFSetting.bodyFontData.toString();
    } on Error {
      PDFSetting.headerFontData = (await rootBundle.load('fonts/carlito/Carlito-Bold.ttf')).buffer.asByteData();
      PDFSetting.bodyFontData = (await rootBundle.load('fonts/carlito/Carlito-Regular.ttf')).buffer.asByteData();
    }

    int errorCount = 0;
    final doc = pw.Document();
    for (var santri in selectedSantriList) {
      var santriNilaiList = nilaiList.where((element) => element.santri == santri).toList();
      if (santriNilaiList.isEmpty) {
        yield '${santri.name} : Tidak ada record nilai.';
        if (printSettings.nhbSemesterPage) errorCount++;
        if (printSettings.nhbBlockPage) errorCount++;
        if (printSettings.npbPage) errorCount++;
        if (printSettings.nkPage) errorCount++;
        if (printSettings.nkAdvicePage) errorCount++;
        continue;
      }
      for (var i = printSettings.fromTimelineInt; i <= printSettings.toTimelineInt; i+=6) {
        final timeline = Timeline.fromInt(i);
        Nilai firstSantriNilai;
        try {
          firstSantriNilai = santriNilaiList.firstWhere((e) => e.timeline.isTimelineMatch(timeline));
        } on StateError {
          yield '${santri.name} - Timeline $timeline : Tidak ada record nilai.';
          continue;
        }

        final docInitialLength = doc.document.pdfPageList.pages.length.toInt();
        NHBContents? nhbContents;
        if (printSettings.nhbSemesterPage || printSettings.npbPage) {
          nhbContents = TableContentsFactory.buildNHBContents(santriNilaiList, timeline);
        }
        if (printSettings.nhbSemesterPage) {
          try {
            final contents = nhbContents!;
            if (contents.moContents.isEmpty && contents.poContents.isEmpty) throw Exception();

            if (contents.moContents.isNotEmpty) {
              final p = page_nhb_semester(headerImage, contents.moContents, firstSantriNilai, isObservation: true);
              doc.addPage(p);
            }
            if (contents.poContents.isNotEmpty) {
              final p = page_nhb_semester(headerImage, contents.poContents, firstSantriNilai);
              doc.addPage(p);
            }
          } catch (e) {
            yield '${santri.name} - Timeline $timeline : Nilai NHB Semester tidak lengkap.';
            errorCount++;
          }
        }
        if (printSettings.nhbBlockPage) {
          try {
            final contents = TableContentsFactory.buildNHBBlockContents(santriNilaiList, timeline);
            if (contents.isEmpty) throw Exception();

            if (contents.length > 3) {
              for (var j = 0; j < contents.length; j+=3) {
                final end = contents.length < (j+3) ? contents.length : j+3;
                final p = page_nhb_block(headerImage, contents.getRange(j, end).toList(), firstSantriNilai);
                doc.addPage(p);
              }
            } else {
              final p = page_nhb_block(headerImage, contents, firstSantriNilai);
              doc.addPage(p);
            }
          } catch (e) {
            yield '${santri.name} - Timeline $timeline : Nilai NHB Block tidak lengkap.';
            errorCount++;
          }
        }
        if (printSettings.npbPage) {
          try {
            final contents = TableContentsFactory.buildNPBContents(nilaiList, timeline);
            if (contents.isEmpty) throw Exception();

            //final p1 = page_npb_chart(headerImage, santriNilaiList, semester: i);
            final p2 = page_npb_table(headerImage, contents, firstSantriNilai, nhbContents: nhbContents);
            //doc.addPage(p1);
            doc.addPage(p2);
          } catch (e) {
            yield '${santri.name} - Timeline $timeline : Nilai NPB tidak lengkap.';
            errorCount++;
          }
        }
        if (printSettings.nkPage || printSettings.nkAdvicePage) {
          try {
            final datasets = ChartDatasetsFactory.buildNKDatasets(santriNilaiList, timeline);
            if (datasets.datasets.isEmpty || datasets.contents.isEmpty) throw Exception();

            final contents = TableContentsFactory.buildNKContents(datasets.contents);
            if (printSettings.nkPage) {
              final p1 = page_nk(headerImage, datasets, contents, firstSantriNilai, timeline);
              doc.addPage(p1);
            }
            if (printSettings.nkAdvicePage) {
              final p2 = page_nk_advice(headerImage, contents, firstSantriNilai);
              doc.addPage(p2);
            }
          } catch (e) {
            yield '${santri.name} - Timeline $timeline : Nilai NK tidak lengkap.';
            if (printSettings.nkPage) errorCount++;
            if (printSettings.nkAdvicePage) errorCount++;
          }
        }

        if (docInitialLength < doc.document.pdfPageList.pages.length.toInt())
          yield '${santri.name} - Timeline $timeline : Rapor berhasil dibuat.';
        else
          yield '${santri.name} - Timeline $timeline : Rapor gagal dibuat.';
      }
    }

    if (errorCount!=0) yield 'Terjadi masalah saat memproses data. $errorCount halaman tidak akan dicetak.';
    if (doc.document.pdfPageList.pages.isEmpty) {
      yield 'Tidak ada halaman yang bisa dicetak.';
    } else {
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => doc.save());
    }
  }

  @override
  Future<void> printDummy() async {
    final headerImage = pw.MemoryImage(
        (await rootBundle.load('assets/images/rapor_header_qbs.png')).buffer.asUint8List()
    );
    try {
      PDFSetting.headerFontData.toString();
      PDFSetting.bodyFontData.toString();
    } on Error {
      PDFSetting.headerFontData = (await rootBundle.load('fonts/carlito/Carlito-Bold.ttf')).buffer.asByteData();
      PDFSetting.bodyFontData = (await rootBundle.load('fonts/carlito/Carlito-Regular.ttf')).buffer.asByteData();
    }

    final timeline1 = Timeline(1, 1, 1, 1);
    final timeline2 = Timeline(7, 2, 1, 1);
    final nhbContents1 = TableContentsFactory.buildNHBContents([d.nilai_s_odd, d.nilai_s_even], timeline1);
    final nhbContents2 = TableContentsFactory.buildNHBContents([d.nilai_s_odd, d.nilai_s_even], timeline2);
    final npbContents1 = TableContentsFactory.buildNPBContents([d.nilai_s_odd], timeline1);
    final npbContents2 = TableContentsFactory.buildNPBContents([d.nilai_s_even], timeline2);
    final nkDatasets1 = ChartDatasetsFactory.buildNKDatasets([d.nilai_s_odd, ...d.nilai_nks], timeline1);
    final nkDatasets2 = ChartDatasetsFactory.buildNKDatasets([d.nilai_s_even, d.nilai_s_even2, d.nilai_s_even3, ...d.nilai_nks], timeline2);
    final nkContents1 = TableContentsFactory.buildNKContents(nkDatasets1.contents);
    final nkContents2 = TableContentsFactory.buildNKContents(nkDatasets2.contents);

    final nhbBlockContents1 = TableContentsFactory.buildNHBBlockContents(
        [d.nilai_block1,d.nilai_block2,d.nilai_block3,d.nilai_block4,d.nilai_block5], timeline1);

    final doc = pw.Document();
    doc.addPage(page_title);
    doc.addPage(page_nhb_semester(headerImage, nhbContents1.moContents, d.nilai_s_odd, isObservation: true));
    doc.addPage(page_nhb_block(headerImage, nhbBlockContents1.getRange(0, 3).toList(), d.nilai_block1));
    doc.addPage(page_nhb_block(headerImage, nhbBlockContents1.getRange(3, 5).toList(), d.nilai_block1));
    doc.addPage(page_npb_table(headerImage, npbContents1, d.nilai_s_odd, nhbContents: nhbContents1));
    doc.addPage(page_nk(headerImage, nkDatasets1, nkContents1, d.nilai_s_odd, timeline1));
    doc.addPage(page_nk_advice(headerImage, nkContents1, d.nilai_s_odd));
    doc.addPage(page_nhb_semester(headerImage, nhbContents2.poContents, d.nilai_s_even));
    doc.addPage(page_npb_table(headerImage, npbContents2, d.nilai_s_even, nhbContents: nhbContents2));
    doc.addPage(page_nk(headerImage, nkDatasets2, nkContents2, d.nilai_s_even, timeline2));
    doc.addPage(page_nk_advice(headerImage, nkContents2, d.nilai_s_even));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}