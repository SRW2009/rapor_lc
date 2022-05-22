import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

import 'package:rapor_lc/dummy_data/contents/npb_contents.dart' as npb;
import 'package:rapor_lc/device/pdf/pdf_common.dart';
import 'package:rapor_lc/device/pdf/pdf_table.dart';

Page page_npb_table(MemoryImage headerImage, List<Nilai> nilaiList, {int semester=1, bool isIT=false}) {
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
              buildPageTitle('NILAI PROSES BELAJAR ${isIT ? '(IT)' : ''}'),
              SizedBox(height: 12.0),
              MyPDFTable.buildIdentityTable(nilaiList.firstWhere((e) => e.BaS.semester==semester)),
              SizedBox(height: 24.0),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: MyPDFTable.buildNPBTable(nilaiList, semester, isIT),
                ),
              ),
              SizedBox(height: 24.0),
              buildPageNumber(2),
            ],
          ),
        ),
      ],
    ),
  );
}