import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

import 'package:rapor_lc/device/pdf/pdf_chart.dart';
import 'package:rapor_lc/device/pdf/pdf_widget.dart';
import 'package:rapor_lc/device/pdf/pdf_table.dart';

Page page_npb_chart(MemoryImage headerImage, List<Nilai> nilaiList, {int semester=1, bool isIT=false}) {
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
          padding: pagePadding,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildPageTitle('Nilai Proses Belajar ${isIT ? '(IT)' : ''}'),
              SizedBox(height: 12.0),
              MyPDFTable.buildIdentityTable(nilaiList.firstWhere((e) => e.timeline.semester==semester)),
              SizedBox(height: 12.0),
              Expanded(
                child: MyPDFChart.buildNPBBarChart(nilaiList, semester, isIT),
              ),
              /*SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Catatan: Jumlah stepping stone pertahun 20.\ntotal dalam setahun 30.',
                  style: const TextStyle(
                    height: 1.15,
                    letterSpacing: 1.1,
                    fontSize: 12.0,
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ],
    ),
  );
}