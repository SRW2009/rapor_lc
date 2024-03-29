
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/common/nk_advice_factory.dart';
import 'package:rapor_lc/device/pdf/pdf_table.dart';
import 'package:rapor_lc/device/pdf/pdf_widget.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';

Page page_nk_advice(MemoryImage headerImage, Map<String, NK> nkContents, Nilai firstNilai) {
  String nkMessage = NKAdviceFactory(nkContents).generate();

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
              buildPageTitle('Nasehat Dewan Guru'),
              SizedBox(height: 12.0),
              MyPDFTable.buildIdentityTable(firstNilai),
              SizedBox(height: 24.0),
              Text(nkMessage, style: bodyTextStyle()),
              SizedBox(height: 80.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20.0),
                  _signatureContainer('\n', 'Wali Santri', '.......................'),
                  //_signatureContainer('Bogor, 18 Desember 2021', 'Wali Kamar', 'Shofia Asri'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _signatureContainer(String date, String signerRank, String signerName) {
  return Container(
    width: 180.0,
    height: 150.0,
    child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(date, style: bodyTextStyle()),
              Text(signerRank, style: bodyTextStyle()),
            ],
          ),
          Text(signerName, style: bodyTextStyle()),
        ]
    ),
  );
}