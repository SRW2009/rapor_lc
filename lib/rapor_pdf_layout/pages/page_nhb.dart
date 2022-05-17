
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

import 'package:rapor_lc/rapor_pdf_layout/pdf_common.dart';
import 'package:rapor_lc/rapor_pdf_layout/pdf_chart.dart';
import 'package:rapor_lc/rapor_pdf_layout/pdf_table.dart';

Page page_nhb(MemoryImage headerImage, List<Nilai> nilaiList, {int semester=1}) {
  return Page(
    margin: const EdgeInsets.all(0),
    pageFormat: PdfPageFormat.a4,
    build: (Context context) => Stack(
      children: [
        Positioned(
          top: 0, left: 0, right: 0,
          child: Image(headerImage),
        ),
        Padding(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildPageTitle('NILAI HASIL BELAJAR (NHB)'),
              SizedBox(height: 12.0),
              MyPDFTable.buildIdentityTable(nilaiList.firstWhere((e) => e.BaS.semester==semester)),
              SizedBox(height: 12.0),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: MyPDFChart.buildNHBPieChart(nilaiList, semester),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              MyPDFTable.buildNHBTable(nilaiList, semester),
            ],
          ),
        ),
      ],
    ),
  );
}