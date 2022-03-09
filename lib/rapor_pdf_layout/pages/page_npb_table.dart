import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/semester.dart';

import 'package:rapor_lc/dummy_data/contents/npb_contents.dart' as npb_;
import 'package:rapor_lc/rapor_pdf_layout/pdf_common.dart';
import '../pdf_table.dart';

Page page_npb_table({int semester=1}) {
  late NPB npb__;
  if (semester == 1) {
    npb__ = npb_.contents_observation.first;
  }
  else {
    npb__ = npb_.contents.first;
  }

  return Page(
    margin: const EdgeInsets.all(80.0),
    pageFormat: PdfPageFormat.a4,
    build: (Context context) => Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildPageTitle('NILAI PROSES BELAJAR'),
          SizedBox(height: 12.0),
          MyPDFTable.buildIdentityTable(npb__.santri, Semester(npb__.semester), npb__.tahunAjaran),
          SizedBox(height: 24.0),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: MyPDFTable.buildNPBTable((semester == 1) ? npb_.contents_observation : npb_.contents),
            ),
          ),
          SizedBox(height: 24.0),
          buildPageNumber(2),
        ],
      ),
  );
}