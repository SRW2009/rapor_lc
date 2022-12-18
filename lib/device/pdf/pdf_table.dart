
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/device/pdf/pdf_global_setting.dart';
import 'package:rapor_lc/device/pdf/pdf_object.dart';
import 'package:rapor_lc/device/pdf/pdf_widget.dart';
import 'package:rapor_lc/domain/entities/nhb_block.dart';
import 'package:rapor_lc/domain/entities/nhb_semester.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';

class MyPDFTable {
  static TableRow _buildHeaderRow(List<String> titles) {
    return TableRow(
      /*decoration: BoxDecoration(
        border: Border.all(color: PdfColors.black, width: 1.0),
      ),*/
      children: titles.map<Widget>((e) => Container(
        //height: 34.0,
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          border: Border.all(color: PdfColors.black, width: 1.0),
          color: PdfColor.fromInt(0xF2F2F2),
        ),
        child: FittedBox(fit: BoxFit.scaleDown, child: Text(e, textAlign: TextAlign.center, style: headerTextStyle(size: font12pt))),
      )).toList(),
    );
  }

  static TableRow _buildContentRow(List<String> contents, {
    PdfColor backgroundColor=PdfColors.white, Border? border, List<TextAlign>? textAligns}) {
    final List<Widget> children = [];
    for (var i = 0; i < contents.length; ++i) {
      var e = contents[i];
      final Widget child = Text(e, textAlign: textAligns?[i], style: bodyTextStyle());
      children.add(
        Container(
          constraints: BoxConstraints(
            minHeight: 20,
            maxHeight: double.infinity,
          ),
          decoration: BoxDecoration(
            border: border ?? Border.all(color: PdfColors.black, width: 1.0),
            color: backgroundColor,
          ),
          //alignment: Alignment.center,
          padding: const EdgeInsets.all(6.0),
          child: child,
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
    final rowContentsAlign = [
      TextAlign.left,
      TextAlign.center,
      TextAlign.center,
      TextAlign.center,
      TextAlign.center,
      TextAlign.center,
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
      padding: const EdgeInsets.all(6.0),
      child: text,
    );

    final List<Widget> rows = [];
    for (var i = 0; i < 6; ++i) {
      final List<Widget> columns = [];
      for (var o in contents) columns.add(
        columnContainer(
          Text(
            rowContents(o)[i], 
            textAlign: rowContentsAlign[i],
            style: bodyTextStyle(),
          ),
        ),
      );
      rows.add(rowContainer(columns, false));
    }
    rows.add(rowContainer([
      Padding(
        padding: const EdgeInsets.all(6),
        child: Text(
          contents.where((e) => e.description.isNotEmpty).fold<String>('', (prev, e) => '$prev${e.description}.\n\n'),
          textAlign: TextAlign.left,
          style: bodyTextStyle(),
        ),
      ),
    ], true));
    return TableRow(children: rows);
  }

  static Widget buildIdentityTable(Nilai nilai) {
    const verticalSpacing = 12.0;

    final santri = nilai.santri,
        timeline = nilai.timeline,
        tahunAjaran = nilai.tahunAjaran;
    return Container(
      padding: const EdgeInsets.only(bottom: 12.0),
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
                  Text('Nama', style: headerTextStyle(size: font12pt)),
                  Text(': ${santri.name}', style: headerTextStyle(size: font12pt)),
                ],
              ),
              TableRow(
                children: [SizedBox(height: verticalSpacing), Container()],
              ),
              TableRow(
                children: [
                  Text('NIS', style: headerTextStyle(size: font12pt)),
                  Text(': ${santri.nis}', style: headerTextStyle(size: font12pt)),
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
                  Text('Level/Kelas/Smt',
                      style: headerTextStyle(size: font12pt)),
                  Text(': ${NumberInRoman.values[timeline.level-1].name}/${NumberInRoman.values[timeline.kelas-1].name}/${NumberInRoman.values[timeline.semester-1].name}',
                      style: headerTextStyle(size: font12pt)),
                ],
              ),
              TableRow(
                children: [SizedBox(height: verticalSpacing), Container()],
              ),
              TableRow(
                children: [
                  Text('Tahun Pelajaran   ', style: headerTextStyle(size: font12pt)),
                  Text(': $tahunAjaran', style: headerTextStyle(size: font12pt)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  static Table buildNHBTable(List<NHBSemester> contents, bool isObservation, Timeline timeline, 
  {int startFrom=0, bool createNormalSituation=false, NHBSemester? normalSituation}) {
    final textAligns = [
      TextAlign.center, TextAlign.left,
      TextAlign.center, TextAlign.center, 
      TextAlign.center, 
      TextAlign.center, 
      TextAlign.center, TextAlign.center,
    ];
    List<TableRow> contentRows = [];
    TableRow? normalSituationRow;
    var i = 0;
    for (var o in contents) {
      contentRows.add(_buildContentRow([
        '${(++i) + startFrom}', o.pelajaran.abbreviation ?? o.pelajaran.name,
        '${o.nilai_harian}', '${o.nilai_bulanan}',
        '${o.nilai_projek!=-1 ? o.nilai_projek : '-'}',
        '${o.nilai_akhir!=-1 ? o.nilai_akhir : '-'}',
        '${o.akumulasi}', o.predikat,
      ], textAligns: textAligns));
    }
    if (createNormalSituation) {
      if (normalSituation != null) {
        normalSituationRow = _buildContentRow([
          '-', normalSituation.pelajaran.name,
          '${normalSituation.nilai_harian}', '${normalSituation.nilai_bulanan}',
          '${normalSituation.nilai_projek!=-1 ? normalSituation.nilai_projek : '-'}',
          '${normalSituation.nilai_akhir!=-1 ? normalSituation.nilai_akhir : '-'}',
          '${normalSituation.akumulasi}', normalSituation.predikat,
        ], textAligns: textAligns);
      } else {
        normalSituationRow = _buildContentRow([
          '-', 'Normal Situation',
          '-', '-', '-', '-', '-', '-',
        ], textAligns: textAligns);
      }
    }

    // build table
    List<TableRow> children = [
      _buildHeaderRow([
        'No', 'Mata Pelajaran\n${isObservation ? 'Masa Observasi' : 'Masa Pasca Observasi'}',
        'Nilai \nHarian', 'Nilai \nBulanan',
        'Nilai \nProject', 'Nilai \nAkhir',
        'NHB', 'Predikat',
      ]),
      ...contentRows,
      if (normalSituationRow!=null) normalSituationRow,
    ];
    return Table(
      tableWidth: TableWidth.max,
      defaultVerticalAlignment: TableCellVerticalAlignment.full,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(flex: 1),
        2: IntrinsicColumnWidth(),
        3: IntrinsicColumnWidth(),
        4: IntrinsicColumnWidth(),
        5: IntrinsicColumnWidth(),
        6: IntrinsicColumnWidth(),
        7: IntrinsicColumnWidth(),
      },
      children: children,
    );
  }

  static Table buildNHBBlockTable(NHBBlockContents contents, {int startFrom=0}) {
    List<TableRow> contentRows = [];
    for (var o in contents) {
      contentRows.add(_buildContentRow(
        [o.key,'','','','','',''],
        backgroundColor: PdfColors.yellow200,
        border: Border(),
        textAligns: [TextAlign.left, TextAlign.center, TextAlign.center, TextAlign.center, TextAlign.center, TextAlign.center, TextAlign.center]
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
        0: IntrinsicColumnWidth(flex: 1),
        1: FixedColumnWidth(44),
        2: FixedColumnWidth(44),
        3: FixedColumnWidth(44),
        4: FixedColumnWidth(36),
        5: FixedColumnWidth(54),
        6: IntrinsicColumnWidth(flex: 1),
      },
      children: children,
    );
  }

  static Table buildNKTable(Map<String, NK> contents, {int startFrom=0}) {
    var i = 0;
    List<TableRow> children = [
      _buildHeaderRow([
        'No', 'Variable', 'Nilai\nMesjid', 'Nilai\nKelas', 'Nilai\nAsrama', 'Akumulatif', 'Predikat',
      ]),
      ...contents.values.map<TableRow>((o) {
        bool isMesjid = o.nilai_mesjid!=-1,
            isKelas = o.nilai_kelas!=-1,
            isAsrama = o.nilai_asrama!=-1;
        return _buildContentRow(
          [
            '${(++i) + startFrom}', o.nama_variabel,
            (isMesjid)?'${o.nilai_mesjid}':'-', (isKelas)?'${o.nilai_kelas}':'-',
            (isAsrama)?'${o.nilai_asrama}':'-', '${o.akumulatif}',
            o.predikat,
          ],
          textAligns: [
            TextAlign.center, TextAlign.left,
            TextAlign.center, TextAlign.center, 
            TextAlign.center, TextAlign.center, 
            TextAlign.center, 
          ],
        );
      }),
    ];
    return Table(
      tableWidth: TableWidth.max,
      defaultVerticalAlignment: TableCellVerticalAlignment.full,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(flex: 1),
        2: IntrinsicColumnWidth(),
        3: IntrinsicColumnWidth(),
        4: IntrinsicColumnWidth(),
        5: IntrinsicColumnWidth(),
        6: IntrinsicColumnWidth(),
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
        return _buildContentRow(
          ['${(++i) + startFrom}', o.pelajaran.name, '${o.n}', ket],
          textAligns: [TextAlign.center, TextAlign.left, TextAlign.center, TextAlign.center]
        );
      })
    ];
    return Table(
      tableWidth: TableWidth.max,
      defaultVerticalAlignment: TableCellVerticalAlignment.full,
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(flex: 3),
        2: IntrinsicColumnWidth(),
        3: IntrinsicColumnWidth(flex: 2),
      },
      children: children,
    );
  }
}