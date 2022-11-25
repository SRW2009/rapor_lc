import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/device/pdf/pdf_object.dart';
import 'package:rapor_lc/device/pdf/pdf_table.dart';
import 'package:rapor_lc/device/pdf/pdf_widget.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

Page page_nhb_block(MemoryImage headerImage, NHBBlockContents contents, Nilai firstNilai) {
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
              buildPageTitle('Nilai Hasil Belajar Block System'),
              SizedBox(height: 12.0),
              MyPDFTable.buildIdentityTable(firstNilai),
              SizedBox(height: 12.0),
              Expanded(child: Align(
                alignment: Alignment.topCenter,
                child: MyPDFTable.buildNHBBlockTable(contents),
              )),
              /*Text(
                _footer,
                textAlign: TextAlign.left,
                style: bodyTextStyle(size: 8),
              ),*/
            ],
          ),
        ),
      ],
    ),
  );
}

final _footer = '''
              Keterangan :
              NH IT bisa diambil dari nilai rata-rata short course.
              Nilai project barangkli nilai kelompok itu dijadikan nilai project.
              Nilai akhir berarti nilai ujian.
              Predikat sesuai rumus yang ada di NHB.
              Deskripsi Progress berisi keterangan capaian santri secara kualitatif selama pembelajaran dengan pendekatan block system.
              
              NH Tahfizh bisa diambil dari rata2 setor harian baik sabak maupun sabki. Di Uji publik tidak perlu diisi nilai NH nya.
              Nilai Project di tahfizh diisi dari nilai uji publik.
              Nilai akhir tahfizh diambil dari rata2 ujian sabak dan rat2 ujian sabki. Ujian Akhir uji publik bisa diisi bisa tidak.
              Predikat sesuai rumus di NHB.
              Deskripsi Progress berisi keterangan capaian santri secara kualitatif selama pembelajaran dengan pendekatan  block system.
              
              Begitu selanjutnya untuk bahasa, QCB dan MK.''';