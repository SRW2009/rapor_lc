
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/device/pdf/pdf_chart.dart';
import 'package:rapor_lc/device/pdf/pdf_data_factory.dart';
import 'package:rapor_lc/device/pdf/pdf_table.dart';
import 'package:rapor_lc/device/pdf/pdf_widget.dart';
import 'package:rapor_lc/domain/entities/nhb_semester.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

Page page_nhb_semester(MemoryImage headerImage, List<NHBSemester> contents, Nilai firstNilai,
    {bool isObservation=false}) {
  final datasets = ChartDatasetsFactory.buildNHBDatasets(contents);

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
              buildPageTitle('Nilai Hasil Belajar'),
              SizedBox(height: 12.0),
              MyPDFTable.buildIdentityTable(firstNilai),
              SizedBox(height: 12.0),
              Expanded(
                child: Center(
                  child: MyPDFChart.buildNHBBarChart(datasets),
                ),
              ),
              SizedBox(height: 12.0),
              MyPDFTable.buildNHBTable(contents, isObservation),
              SizedBox(height: 18.0),
              Text(
                '* Nilai minimal kelulusan adalah ${LoadedSettings.nhbMinValToPass}.',
                    /*'* Singkatan: ${contents
                    .where((value) => value.pelajaran.abbreviation != null)
                    .fold<String>('', (prev, e) => '$prev${e.pelajaran.abbreviation} adalah ${e.pelajaran.name}. ')}',*/
                textAlign: TextAlign.left,
                style: headerTextStyle(size: 11),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}