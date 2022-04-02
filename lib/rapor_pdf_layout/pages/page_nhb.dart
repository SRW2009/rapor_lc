
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:rapor_lc/dummy_data/datasets/nhb_datasets.dart' as nhb;
import 'package:rapor_lc/dummy_data/contents/nhb_contents.dart' as nhb_;
import 'package:rapor_lc/rapor_pdf_layout/pdf_common.dart';
import 'package:rapor_lc/rapor_pdf_layout/pdf_chart.dart';
import 'package:rapor_lc/rapor_pdf_layout/pdf_table.dart';

Page page_nhb({int semester=1}) {
  return Page(
    margin: const EdgeInsets.all(0),
    pageFormat: PdfPageFormat.a4,
    build: (Context context) => Stack(
      children: [
        Positioned.fill(child: Container(

        )),
        Padding(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildPageTitle('NILAI HASIL BELAJAR (NHB)'),
              SizedBox(height: 12.0),
              MyPDFTable.buildIdentityTable(nhb_.nilai[semester-1]),
              SizedBox(height: 12.0),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: MyPDFChart.buildNHBPieChart(nhb.datasets),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              MyPDFTable.buildNHBTable(nhb_.nilai[semester-1].nhb ?? []),
            ],
          ),
        ),
      ],
    ),
  );
}