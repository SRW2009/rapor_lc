
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/semester.dart';
import 'package:rapor_lc/rapor_pdf_layout/pdf_common.dart';

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
  
  static Widget buildIdentityTable(Santri santri, Semester semester, String tahunAjaran) {
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
                  timesText(': ${santri.nama}'),
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
                  timesText(': ${semester.n} (${semester.toString()})'),
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
  
  static Table buildNHBTable(List<NHB> nhbs, {int startFrom=0}) {
    List<TableRow> children = [
      _buildHeaderRow([
        'No', 'Mata Pelajaran' ,
        'Nilai \nHarian', 'Nilai \nBulanan',
        'Nilai \nProject', 'Nilai \nAkhir',
        'Akumulasi', 'Predikat',
      ]),
    ];
    for (var i = 0; i < nhbs.length; ++i) {
      var o = nhbs[i];
      children.add(_buildContentRow([
        '${i + 1 + startFrom}', o.mataPelajaran.namaMapel,
        '${o.nilaiHarian}', '${o.nilaiBulanan}',
        '${o.nilaiProject}', '${o.nilaiAkhir}',
        '${o.akumulasi}', o.predikat
      ]));
    }

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

  static Table buildNKTable(List<NK> nks) {
    List<TableRow> children = [
      _buildHeaderRow([
        'No', 'Variable', 'Nilai Mesjid', 'Nilai Kelas', 'Nilai Asrama', 'Akumulatif', 'Predikat',
      ]),
    ];
    for (var i = 0; i < nks.length; ++i) {
      var o = nks[i];
      children.add(_buildContentRow([
        '${i + 1}', o.variable,
        '${o.nilaiMesjid}', '${o.nilaiKelas}',
        '${o.nilaiAsrama}', '${o.akumulatif}',
        o.predikat
      ]));
    }

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

  static Table buildNPBTable(List<NPB> npbs, {int startFrom=0}) {
    List<TableRow> children = [
      _buildHeaderRow([
        'No', 'Nama Mapel', '/N', 'Presensi'
      ]),
    ];
    for (var i = 0; i < npbs.length; ++i) {
      var o = npbs[i];
      children.add(_buildContentRow([
        '${i + 1 + startFrom}', o.pelajaran.namaMapel,
        '${(o is NPBMO) ? o.n : o.semester}', (o.presensi),
      ]));
    }

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

  static Table buildNPBPOTable(List<NPBPO> npbpos) {
    List<TableRow> children = [
      TableRow(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: PdfColors.black, width: 1.0),
          ),
        ),
        children: [
          Container(
            constraints: const BoxConstraints(
              minWidth: 1.0,
            ),
            height: 25.0,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: PdfColors.black, width: 1.0),
                right: BorderSide(color: PdfColors.black, width: 1.0),
              ),
            ),
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(fit: BoxFit.scaleDown, child: Text('No', textAlign: TextAlign.center, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold))),
          ),
          Container(
            constraints: const BoxConstraints(
              minWidth: 1.0,
              minHeight: 1.0,
            ),
            height: 25.0,
          ),
          Container(
            constraints: const BoxConstraints(
              minWidth: 1.0,
              minHeight: 1.0,
            ),
            height: 25.0,
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(fit: BoxFit.scaleDown, child: Text('IT', textAlign: TextAlign.center, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold))),
          ),
          Container(
            constraints: const BoxConstraints(
              minWidth: 1.0,
              minHeight: 1.0,
            ),
            height: 25.0,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: PdfColors.black, width: 1.0),
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              minWidth: 1.0,
              minHeight: 1.0,
            ),
            height: 25.0,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: PdfColors.black, width: 1.0),
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              minWidth: 1.0,
              minHeight: 1.0,
            ),
            height: 25.0,
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(fit: BoxFit.scaleDown, child: Text('Tahfiz', textAlign: TextAlign.center, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold))),
          ),
          Container(
            constraints: const BoxConstraints(
              minWidth: 1.0,
              minHeight: 1.0,
            ),
            height: 25.0,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: PdfColors.black, width: 1.0),
              ),
            ),
          ),
        ],
      ),
      TableRow(
        children: [
          '', 'Nama PLP', '/N', 'Presensi', 'Nama PLP', '/N', 'Presensi',
        ].map<Widget>((e) {
          if (e.isEmpty || e == '') {
            return Container(
              width: 1.0,
              height: 25.0,
              padding: const EdgeInsets.all(6.0),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: PdfColors.black, width: 1.0),
                ),
              ),
            );
          }
          return Container(
            height: 25.0,
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              border: Border.all(color: PdfColors.black, width: 1.0),
            ),
            child: FittedBox(fit: BoxFit.scaleDown, child: Text(e, textAlign: TextAlign.center, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold))),
          );
        }).toList(),
      ),
    ];
    var no = 1;
    for (var i = 0; i < npbpos.length; i+=2) {
      var o = npbpos[i];
      var o2 = npbpos[i+1];
      children.add(_buildContentRow([
        '${no++}',
        o.pelajaran.namaMapel, '${o.semester}', (o.presensi),
        o2.pelajaran.namaMapel, '${o2.semester}', (o2.presensi),
      ]));

    }

    return Table(
      tableWidth: TableWidth.max,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(flex: 1),
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