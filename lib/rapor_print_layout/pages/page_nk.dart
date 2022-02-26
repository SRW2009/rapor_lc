
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/semester.dart';

import 'package:rapor_lc/dummy_data/datasets/nk_datasets.dart' as nk;
import 'package:rapor_lc/dummy_data/contents/nk_contents.dart' as nk_;
import '../pdf_chart.dart';
import '../pdf_common.dart';
import '../pdf_table.dart';

Page page_nk({int semester=1}) {
  NK nk__ = nk_.contents.first;

  return Page(
    margin: const EdgeInsets.all(80.0),
    pageFormat: PdfPageFormat.a4,
    build: (Context context) => Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildPageTitle('NILAI KEMANDIRIAN'),
          SizedBox(height: 12.0),
          MyPDFTable.buildIdentityTable(nk__.santri, Semester(semester), nk__.tahunAjaran),
          SizedBox(height: 12.0),
          Expanded(
            child: Center(
              child:
              SizedBox(
                width: 500.0,
                height: 400.0,
                child: MyPDFChart.buildNKLineChart(nk.datasets),
              ),
            ),
          ),
          SizedBox(height: 12.0),
          MyPDFTable.buildNKTable(nk_.contents),
        ],
      ),
  );
}