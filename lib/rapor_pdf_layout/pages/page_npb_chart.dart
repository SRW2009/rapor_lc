import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/semester.dart';

import 'package:rapor_lc/dummy_data/datasets/npb_datasets.dart' as npb;
import 'package:rapor_lc/dummy_data/contents/npb_contents.dart' as npb_;
import '../pdf_chart.dart';
import '../pdf_common.dart';
import '../pdf_table.dart';

Page page_npb_chart({int semester=1}) {
  NPB npb__;
  if (semester == 1) {
    npb__ = npb_.contents_observation.first;
  }
  else {
    npb__ = npb_.contents.first;
  }
  List<String> plpsName = []
  ..addAll(npb.plpsName_observation)
  ..addAll(npb.plpsName);

  return Page(
    margin: const EdgeInsets.all(80.0),
    pageFormat: PdfPageFormat.a4,
    build: (Context context) => Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildPageTitle('NILAI PROSES BELAJAR'),
          SizedBox(height: 12.0),
          MyPDFTable.buildIdentityTable(npb__.santri, Semester(npb__.semester), npb__.tahun_ajaran),
          SizedBox(height: 12.0),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: MyPDFChart.buildNPBBarChart(plpsName, npb.getDatasets(isObservation: (semester == 1))),
              ),
            ),
          ),
          SizedBox(height: 12.0),
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
          ),
          SizedBox(height: 12.0),
          buildPageNumber(1),
        ],
      ),
  );
}