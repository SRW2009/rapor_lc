
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/device/pdf/pdf_common.dart';
import 'package:rapor_lc/device/pdf/pdf_data_factory.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class MyPDFTable {
  static TableRow _buildHeaderRow(List<String> titles) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border.all(color: PdfColors.black, width: 1.0),
      ),
      children: titles.map<Widget>((e) => Container(
        height: 30.0,
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          border: Border.all(color: PdfColors.black, width: 1.0),
        ),
        child: FittedBox(fit: BoxFit.scaleDown, child: Text(e, textAlign: TextAlign.center, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold))),
      )).toList(),
    );
  }

  static TableRow _buildContentRow(List<String> contents) {
    return TableRow(
      children: contents.map<Widget>((e) => Container(
        height: 20.0,
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(color: PdfColors.black, width: 1.0),
        ),
        child: FittedBox(fit: BoxFit.scaleDown, child: Text(e, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10.0))),
      )).toList(),
    );
  }
  
  static Widget buildIdentityTable(Nilai nilai) {
    final santri = nilai.santri,
        semester = nilai.BaS.semesterToString(),
        tahunAjaran = nilai.tahunAjaran;
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(
          color: PdfColors.grey500,
        )),
      ),
      padding: const EdgeInsets.only(bottom: 12.0, left: 12.0, right: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Table(
            tableWidth: TableWidth.min,
            columnWidths: const {
              0: IntrinsicColumnWidth(),
              1: IntrinsicColumnWidth(),
            },
            children: [
              TableRow(
                children: [
                  timesText('Nama   '),
                  timesText(': ${santri.name}'),
                ],
              ),
              TableRow(
                children: [ SizedBox(height: 10.0), Container() ],
              ),
              TableRow(
                children: [
                  timesText('NIS'),
                  timesText(': ${santri.nis}'),
                ],
              ),
            ],
          ),
          Table(
            tableWidth: TableWidth.min,
            columnWidths: const {
              0: IntrinsicColumnWidth(),
              1: IntrinsicColumnWidth(),
            },
            children: [
              TableRow(
                children: [
                  timesText('Semester'),
                  timesText(': $semester'),
                ],
              ),
              TableRow(
                children: [ SizedBox(height: 10.0), Container() ],
              ),
              TableRow(
                children: [
                  timesText('Tahun Pelajaran   '),
                  timesText(': $tahunAjaran'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  static Table buildNHBTable(List<Nilai> nilaiList, int semester, {int startFrom=0}) {
    final contents = TableContentsFactory.buildNHBContents(nilaiList, semester);

    // build table
    var i = 0;
    List<TableRow> children = [
      _buildHeaderRow([
        'No', 'Mata Pelajaran' ,
        'Nilai \nHarian', 'Nilai \nBulanan',
        'Nilai \nProject', 'Nilai \nAkhir',
        'Akumulasi', 'Predikat',
      ]),
      ...contents.values.map<TableRow>((o) => _buildContentRow([
        '${(++i) + startFrom}', o.pelajaran.name,
        '${o.nilai_harian}', '${o.nilai_bulanan}',
        '${o.nilai_projek}', '${o.nilai_akhir}',
        '${o.akumulasi}', o.predikat
      ])),
    ];
    return Table(
      tableWidth: TableWidth.max,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(flex: 2),
        2: IntrinsicColumnWidth(flex: 1),
        3: IntrinsicColumnWidth(flex: 1),
        4: IntrinsicColumnWidth(flex: 1),
        5: IntrinsicColumnWidth(flex: 1),
        6: IntrinsicColumnWidth(flex: 1),
        7: IntrinsicColumnWidth(flex: 1),
        8: IntrinsicColumnWidth(flex: 1),
      },
      children: children,
    );
  }

  static Table buildNKTable(List<Nilai> nilaiList, int semester, {int startFrom=0}) {
    final contents = TableContentsFactory.buildNKContents(nilaiList, semester);

    var i = 0;
    List<TableRow> children = [
      _buildHeaderRow([
        'No', 'Variable', 'Nilai Mesjid', 'Nilai Kelas', 'Nilai Asrama', 'Akumulatif', 'Predikat',
      ]),
      ...contents.values.map<TableRow>((o) => _buildContentRow([
        '${(++i) + startFrom}', o.nama_variabel,
        '${o.nilai_mesjid}', '${o.nilai_kelas}',
        '${o.nilai_asrama}', '${o.akumulatif}',
        o.predikat,
      ])),
    ];
    return Table(
      tableWidth: TableWidth.max,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(flex: 2),
        2: IntrinsicColumnWidth(flex: 1),
        3: IntrinsicColumnWidth(flex: 1),
        4: IntrinsicColumnWidth(flex: 1),
        5: IntrinsicColumnWidth(flex: 1),
        6: IntrinsicColumnWidth(flex: 1),
      },
      children: children,
    );
  }

  static Table buildNPBTable(List<Nilai> nilaiList, int semester, bool isIT, {int startFrom=0}) {
    final contents = TableContentsFactory.buildNPBContents(nilaiList, semester, isIT);

    // build table
    var i = 0;
    List<TableRow> children = [
      // header
      _buildHeaderRow([
        'No', 'Nama Mapel', '/N', 'Presensi'
      ]),
      //contents
      ...contents.map((o) => _buildContentRow([
        '${(++i) + startFrom}', o.item.pelajaran.name,
        '${o.n}', o.item.presensi,
      ]))
    ];
    return Table(
      tableWidth: TableWidth.max,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(flex: 2),
        2: IntrinsicColumnWidth(flex: 1),
        3: IntrinsicColumnWidth(flex: 1),
        4: IntrinsicColumnWidth(flex: 1),
        5: IntrinsicColumnWidth(flex: 1),
        6: IntrinsicColumnWidth(flex: 1),
      },
      children: children,
    );
  }
}