
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/device/pdf/pdf_chart.dart';
import 'package:rapor_lc/device/pdf/pdf_object.dart';
import 'package:rapor_lc/device/pdf/pdf_table.dart';
import 'package:rapor_lc/device/pdf/pdf_widget.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';

Page page_nk(MemoryImage headerImage, NKDatasets datasets, NKContents contents, Nilai firstNilai, Timeline timeline) {
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
              buildPageTitle('Nilai Kemandirian'),
              SizedBox(height: 12.0),
              MyPDFTable.buildIdentityTable(firstNilai),
              SizedBox(height: 12.0),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 300,
                    child: MyPDFChart.buildNKLineChart(datasets, timeline),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              MyPDFTable.buildNKTable(contents),
            ],
          ),
        ),
      ],
    ),
  );
}