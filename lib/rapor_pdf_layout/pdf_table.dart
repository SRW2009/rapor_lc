
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/common/item_frequency.dart';
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
    // key of this map is mapel id
    Map<int, NHB> nhbValueMap = {};

    // process nhb to match parameters
    for (var nilai in nilaiList) {
      // only take nilai that match requested semester
      if (nilai.BaS.semester != semester) continue;

      for (var o in nilai.nhb) {
        // update value
        nhbValueMap.update(
          o.pelajaran.id,
          (v) {
            // calculate mean of both value
            num harian = (v.nilai_harian+o.nilai_harian)/2;
            num bulanan = (v.nilai_bulanan+o.nilai_bulanan)/2;
            num projek = (v.nilai_projek+o.nilai_projek)/2;
            num akhir = (v.nilai_akhir+o.nilai_akhir)/2;

            // NaN checker
            harian = harian.isNaN ? 0 : harian;
            bulanan = bulanan.isNaN ? 0 : bulanan;
            projek = projek.isNaN ? 0 : projek;
            akhir = akhir.isNaN ? 0 : akhir;

            var acc = NilaiCalculation.accumulate([harian.round(), bulanan.round(), projek.round(), akhir.round()]);
            var pred = NilaiCalculation.toPredicate(acc);
            return NHB(v.no, v.pelajaran, harian.round(), bulanan.round(), projek.round(), akhir.round(), acc, pred);
          },
          ifAbsent: () {
            var acc = NilaiCalculation.accumulate([o.nilai_harian, o.nilai_bulanan, o.nilai_projek, o.nilai_akhir]);
            var pred = NilaiCalculation.toPredicate(acc);
            return NHB(o.no, o.pelajaran, o.nilai_harian, o.nilai_bulanan, o.nilai_projek, o.nilai_akhir, acc, pred);
          },
        );
      }
    }

    // build table
    var i = 0;
    List<TableRow> children = [
      _buildHeaderRow([
        'No', 'Mata Pelajaran' ,
        'Nilai \nHarian', 'Nilai \nBulanan',
        'Nilai \nProject', 'Nilai \nAkhir',
        'Akumulasi', 'Predikat',
      ]),
      ...nhbValueMap.entries.map<TableRow>((o) => _buildContentRow([
        '${(++i) + startFrom}', o.value.pelajaran.name,
        '${o.value.nilai_harian}', '${o.value.nilai_bulanan}',
        '${o.value.nilai_projek}', '${o.value.nilai_akhir}',
        '${o.value.akumulasi}', o.value.predikat
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
        '${i + 1}', o.nama_variabel,
        '${o.nilai_mesjid}', '${o.nilai_kelas}',
        '${o.nilai_asrama}', '${o.akumulatif}',
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

  static Table buildNPBTable(List<Nilai> nilaiList, int semester, bool isIT, {int startFrom=0}) {
    List<int> ids = [];
    List<ItemFrequency<NPB>> processedNPB = [];

    // process npb to match parameters
    for (var nilai in nilaiList) {
      // only take nilai that match requested semester
      if (nilai.BaS.semester != semester) continue;

      for (var o in nilai.npb) {
        // separate npb by IT division or not
        if (isIT && o.pelajaran.divisi!.name != 'IT') continue;
        if (!isIT && o.pelajaran.divisi!.name == 'IT') continue;

        // if item exist, update item frequency
        if (ids.contains(o.no)) {
          processedNPB.firstWhere((element) => element.item.no==o.no).n++;
          continue;
        }
        // otherwise add item to data
        ids.add(o.no);
        processedNPB.add(ItemFrequency(o, n: 1));
      }
    }

    // build table
    var i = 0;
    List<TableRow> children = [
      // header
      _buildHeaderRow([
        'No', 'Nama Mapel', '/N', 'Presensi'
      ]),
      //contents
      ...processedNPB.map((o) => _buildContentRow([
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