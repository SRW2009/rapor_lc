import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/device/pdf/pdf_data_factory.dart';
import 'package:rapor_lc/device/pdf/pdf_global_setting.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/device/pdf/pdf_widget.dart';
import 'package:rapor_lc/device/pdf/pdf_table.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';

// TODO: make footer note customizable by teacher
Page page_npb_table(MemoryImage headerImage, List<Nilai> nilaiList, Timeline timeline) {
  final contents = TableContentsFactory.buildNPBContents(nilaiList, timeline);

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
              buildPageTitle('Nilai Proses Belajar'),
              SizedBox(height: 12.0),
              MyPDFTable.buildIdentityTable(nilaiList.firstWhere((e) => e.timeline.isTimelineMatch(timeline))),
              SizedBox(height: 12.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SINGLE LANE
                  if (contents.length <= PDFSetting.npbMaxRow) Expanded(
                    child: MyPDFTable.buildNPBTable(contents),
                  ),
                  // DOUBLE LANE
                  if (contents.length > PDFSetting.npbMaxRow) Expanded(
                    child: MyPDFTable.buildNPBTable(contents.sublist(0, PDFSetting.npbMaxRow)),
                  ),
                  if (contents.length > PDFSetting.npbMaxRow) SizedBox(width: 18),
                  if (contents.length > PDFSetting.npbMaxRow) Expanded(
                    child: MyPDFTable.buildNPBTable(contents.sublist(
                        PDFSetting.npbMaxRow,
                        contents.length<(PDFSetting.npbMaxRow*2)?contents.length:(PDFSetting.npbMaxRow*2),
                    )),
                  ),
                ],
              ),
              SizedBox(height: 18.0),
              Text(
                '* Alhamdulillah, pada semester ini, ananda telah menempuh '
                '${contents.fold<int>(0, (previousValue, element) => previousValue+element.n)} stepping stone.\n\n'
                'Prediksi stepping stone yang akan ananda jalankan hingga 3 tahun sebanyak ${contents.length} stepping stone.',
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