
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/device/pdf/pdf_object.dart';
import 'package:rapor_lc/device/pdf/pdf_widget.dart';
import 'package:rapor_lc/domain/entities/nhb_block.dart';
import 'package:rapor_lc/domain/entities/nhb_semester.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npb.dart';

class MyPDFTable {
  static TableRow _buildHeaderRow(List<String> titles) {
    return TableRow(
      /*decoration: BoxDecoration(
        border: Border.all(color: PdfColors.black, width: 1.0),
      ),*/
      children: titles.map<Widget>((e) => Container(
        height: 30.0,
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          border: Border.all(color: PdfColors.black, width: 1.0),
          color: PdfColor.fromInt(0xF2F2F2),
        ),
        child: FittedBox(fit: BoxFit.scaleDown, child: Text(e, textAlign: TextAlign.center, style: headerTextStyle(size: 10))),
      )).toList(),
    );
  }

  static TableRow _buildContentRow(List<String> contents, {
    PdfColor backgroundColor=PdfColors.white, Border? border, bool looseHeight=false, List<double>? textSizes}) {
    final List<Widget> children = [];
    for (var i = 0; i < contents.length; ++i) {
      var e = contents[i];
      final Widget child = Text(e, textAlign: TextAlign.center, style: bodyTextStyle(size: textSizes?[i] ?? 10));
      children.add(
        Container(
          constraints: BoxConstraints(
            minHeight: 20,
            maxHeight: looseHeight ? double.infinity : 20.0,
          ),
          decoration: BoxDecoration(
            border: border ?? Border.all(color: PdfColors.black, width: 1.0),
            color: backgroundColor,
          ),
          //alignment: Alignment.center,
          padding: const EdgeInsets.all(3.0),
          child: looseHeight ? Center(child: child) : FittedBox(fit: BoxFit.scaleDown, child: child),
        ),
      );
    }
    return TableRow(children: children);
  }

  static TableRow _buildNHBBlockContentRow(List<NHBBlock> contents) {
    rowContents(NHBBlock v) => [
      v.pelajaran.name,
      '${v.nilai_harian}',
      '${v.nilai_projek!=-1 ? v.nilai_projek : '-'}',
      '${v.nilai_akhir!=-1 ? v.nilai_akhir : '-'}',
      '${v.akumulasi}', v.predikat
    ];
    rowContainer(List<Widget> columnChildren, bool isDescription) => Container(
      constraints: BoxConstraints(
        minHeight: 20,
        maxHeight: double.infinity,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: PdfColors.black, width: 1.0),
        color: PdfColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: isDescription ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: columnChildren,
      ),
    );
    columnContainer(Text text) => Container(
      constraints: BoxConstraints(
        minHeight: 20,
        maxHeight: 20,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: PdfColors.black, width: 1.0),
        color: PdfColors.white,
      ),
      padding: const EdgeInsets.all(3.0),
      child: FittedBox(fit: BoxFit.scaleDown, child: text),
    );

    final List<Widget> rows = [];
    for (var i = 0; i < 6; ++i) {
      final List<Widget> columns = [];
      for (var o in contents) columns.add(
        columnContainer(
          Text(rowContents(o)[i], textAlign: TextAlign.center, style: bodyTextStyle(size: 10)),
        ),
      );
      rows.add(rowContainer(columns, false));
    }
    rows.add(rowContainer([
      Padding(
        padding: const EdgeInsets.all(3),
        child: Text(
          contents.where((e) => e.description.isNotEmpty).fold<String>('', (prev, e) => '$prev${e.description}.\n\n'),
          textAlign: TextAlign.center,
          style: bodyTextStyle(size: 8),
        ),
      ),
    ], true));
    return TableRow(children: rows);
  }

  static Widget buildIdentityTable(Nilai nilai) {
    const verticalSpacing = 6.0;

    final santri = nilai.santri,
        timeline = nilai.timeline,
        tahunAjaran = nilai.tahunAjaran;
    return Container(
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
                  Text('Nama', style: headerTextStyle(size: 12)),
                  Text(': ${santri.name}', style: headerTextStyle(size: 12)),
                ],
              ),
              TableRow(
                children: [ SizedBox(height: verticalSpacing), Container() ],
              ),
              TableRow(
                children: [
                  Text('NIS', style: headerTextStyle(size: 12)),
                  Text(': ${santri.nis}', style: headerTextStyle(size: 12)),
                ],
              ),
              TableRow(
                children: [ SizedBox(height: verticalSpacing), Container() ],
              ),
              TableRow(
                children: [
                  Text('Tahun Pelajaran   ', style: headerTextStyle(size: 12)),
                  Text(': $tahunAjaran', style: headerTextStyle(size: 12)),
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
                  Text('Level', style: headerTextStyle(size: 12)),
                  Text(': ${timeline.levelReadable}', style: headerTextStyle(size: 12)),
                ],
              ),
              TableRow(
                children: [ SizedBox(height: verticalSpacing), Container() ],
              ),
              TableRow(
                children: [
                  Text('Kelas', style: headerTextStyle(size: 12)),
                  Text(': ${timeline.kelasReadable}', style: headerTextStyle(size: 12)),
                ],
              ),
              TableRow(
                children: [ SizedBox(height: verticalSpacing), Container() ],
              ),
              TableRow(
                children: [
                  Text('Semester   ', style: headerTextStyle(size: 12)),
                  Text(': ${timeline.semesterReadable}', style: headerTextStyle(size: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  static Table buildNHBTable(List<NHBSemester> contents, bool isObservation, {int startFrom=0}) {
    List<TableRow> contentRows = [];
    TableRow? normalSituationRow;
    var i = 0;
    for (var o in contents) {
      if (o.pelajaran.name=='Normal Situation') {
        normalSituationRow = _buildContentRow([
          '${(++i) + startFrom}', o.pelajaran.name,
          '${o.nilai_harian}', '${o.nilai_bulanan}',
          '${o.nilai_projek!=-1 ? o.nilai_projek : '-'}',
          '${o.nilai_akhir!=-1 ? o.nilai_akhir : '-'}',
          '${o.akumulasi}', o.predikat,
        ]);
        continue;
      }

      contentRows.add(_buildContentRow([
        '${(++i) + startFrom}', o.pelajaran.abbreviation ?? o.pelajaran.name,
        '${o.nilai_harian}', '${o.nilai_bulanan}',
        '${o.nilai_projek!=-1 ? o.nilai_projek : '-'}',
        '${o.nilai_akhir!=-1 ? o.nilai_akhir : '-'}',
        '${o.akumulasi}', o.predikat,
      ]));
    }
    normalSituationRow ??= _buildContentRow([
      '${(++i) + startFrom}', 'Normal Situation',
      '-', '-', '-', '-', '-', '-',
    ]);

    // build table
    List<TableRow> children = [
      _buildHeaderRow([
        'No', 'Mata Pelajaran\n${isObservation ? 'Masa Observasi' : 'Paska Observasi'}',
        'Nilai \nHarian', 'Nilai \nBulanan',
        'Nilai \nProject', 'Nilai \nAkhir',
        'NHB', 'Predikat',
      ]),
      ...contentRows,
      normalSituationRow,
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

  static Table buildNHBBlockTable(NHBBlockContents contents, {int startFrom=0}) {
    List<TableRow> contentRows = [];
    for (var o in contents) {
      contentRows.add(_buildContentRow(
        ['','','',o.key,'','',''],
        backgroundColor: PdfColors.yellow200,
        border: Border(),
      ));
      contentRows.add(_buildNHBBlockContentRow(o.value));
    }

    // build table
    List<TableRow> children = [
      _buildHeaderRow([
        'Mata Pelajaran\n(Block System)',
        'Nilai \nHarian', 'Nilai \nProject', 'Nilai \nAkhir',
        'NHB', 'Predikat', 'Kualitas NJS',
      ]),
      ...contentRows,
    ];
    return Table(
      tableWidth: TableWidth.max,
      border: TableBorder.symmetric(
        outside: BorderSide(color: PdfColors.black, width: 1.0),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.full,
      columnWidths: const {
        0: IntrinsicColumnWidth(flex: 3),
        1: IntrinsicColumnWidth(flex: 1.2),
        2: IntrinsicColumnWidth(flex: 1.2),
        3: IntrinsicColumnWidth(flex: 1.2),
        4: IntrinsicColumnWidth(flex: 1.2),
        5: IntrinsicColumnWidth(flex: 1.2),
        6: IntrinsicColumnWidth(flex: 3),
      },
      children: children,
    );
  }

  static Table buildNKTable(Map<String, NK> contents, {int startFrom=0}) {
    var i = 0;
    List<TableRow> children = [
      _buildHeaderRow([
        'No', 'Variable', 'Nilai Mesjid', 'Nilai Kelas', 'Nilai Asrama', 'Akumulatif', 'Predikat',
      ]),
      ...contents.values.map<TableRow>((o) {
        bool isMesjid = o.nilai_mesjid!=-1,
            isKelas = o.nilai_kelas!=-1,
            isAsrama = o.nilai_asrama!=-1;
        return _buildContentRow([
          '${(++i) + startFrom}', o.nama_variabel,
          (isMesjid)?'${o.nilai_mesjid}':'-', (isKelas)?'${o.nilai_kelas}':'-',
          (isAsrama)?'${o.nilai_asrama}':'-', '${o.akumulatif}',
          o.predikat,
        ]);
      }),
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

  static Table buildNPBTable(List<NPB> contents, List<NHBSemester> nhbs, {int startFrom=0}) {
    // build table
    var i = 0;
    List<TableRow> children = [
      // header
      _buildHeaderRow([
        'No', 'Stepping Stone', '/N', 'Keterangan'
      ]),
      //contents
      ...contents.map((o) {
        String ket = 'N/A';
        int nhbI = nhbs.indexWhere((element) => o.pelajaran==element.pelajaran);
        if (nhbI!=-1 && o.n>0) {
          ket = (nhbs[nhbI].akumulasi >= LoadedSettings.nhbMinValToPass) ? 'Lulus' : 'Tidak Lulus';
        }
        return _buildContentRow([
          '${(++i) + startFrom}', o.pelajaran.name, '${o.n}', ket
        ]);
      })
    ];
    return Table(
      tableWidth: TableWidth.max,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(flex: 2),
        2: IntrinsicColumnWidth(flex: 1),
        3: IntrinsicColumnWidth(flex: 2),
      },
      children: children,
    );
  }
}