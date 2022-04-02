import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:rapor_lc/dummy_data/contents/npb_contents.dart' as npb;
import 'package:rapor_lc/rapor_pdf_layout/pdf_common.dart';
import 'package:rapor_lc/rapor_pdf_layout/pdf_table.dart';

Page page_npb_table({int semester=1}) {
  return Page(
    margin: const EdgeInsets.all(80.0),
    pageFormat: PdfPageFormat.a4,
    build: (Context context) => Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildPageTitle('NILAI PROSES BELAJAR'),
          SizedBox(height: 12.0),
          MyPDFTable.buildIdentityTable(npb.nilai[semester-1]),
          SizedBox(height: 24.0),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: MyPDFTable.buildNPBTable(npb.nilai[semester-1]),
            ),
          ),
          SizedBox(height: 24.0),
          buildPageNumber(2),
        ],
      ),
  );
}