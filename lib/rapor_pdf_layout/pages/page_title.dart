import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:rapor_lc/dummy_data/datasets/npb_datasets.dart' as npb;
import 'package:rapor_lc/dummy_data/contents/npb_contents.dart' as npb_;
import '../pdf_chart.dart';
import '../pdf_table.dart';

final page_title = Page(
  margin: const EdgeInsets.all(100.0),
  pageFormat: PdfPageFormat.a4,
  build: (Context context) {
    return Stack(
      children: [
        Center(
          child: Text(
            'Blueprint Rapor LC Sekolah Impian',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26.0,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150.0,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: PdfColors.black, width: 1.0),
                  ),
                ),
              ),
              Container(
                width: 150.0,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: PdfColors.black, width: 1.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  },
);