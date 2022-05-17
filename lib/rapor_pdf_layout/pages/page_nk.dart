
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

import 'package:rapor_lc/dummy_data/contents/nk_contents.dart' as nk_;
import 'package:rapor_lc/rapor_pdf_layout/pdf_chart.dart';
import 'package:rapor_lc/rapor_pdf_layout/pdf_common.dart';
import 'package:rapor_lc/rapor_pdf_layout/pdf_table.dart';

Page page_nk(MemoryImage headerImage, List<Nilai> nilaiList, {int semester=1}) {
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
              buildPageTitle('NILAI KEMANDIRIAN'),
              SizedBox(height: 12.0),
              MyPDFTable.buildIdentityTable(nilaiList.firstWhere((e) => e.BaS.semester==semester)),
              SizedBox(height: 12.0),
              Expanded(
                child: Center(
                  child:
                  SizedBox(
                    width: 500.0,
                    height: 400.0,
                    child: MyPDFChart.buildNKLineChart(nilaiList, semester),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              MyPDFTable.buildNKTable(nk_.nilai[semester-1].nk),
            ],
          ),
        ),
      ],
    ),
  );
}