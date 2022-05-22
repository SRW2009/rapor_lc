
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:rapor_lc/dummy_data/contents/nk_contents.dart' as nk_;
import 'package:rapor_lc/device/pdf/pdf_common.dart';

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
            Text(date),
            Text(signerRank),
          ],
        ),
        Text(signerName),
      ]
    ),
  );
}

Page page_nk_advice(MemoryImage headerImage) {
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
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildPageTitle(nk_.adviceTitle),
              SizedBox(height: 24.0),
              Text(nk_.adviceContent),
              SizedBox(height: 80.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _signatureContainer('\n', 'Wali Santri', '.......................'),
                  _signatureContainer('Bogor, 18 Desember 2021', 'Wali Kamar', 'Shofia Asri'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}