
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rapor_lc/app/dialogs/admin/print_dialog.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/dashboard/admin_home_dashboard_controller.dart';
import 'package:rapor_lc/app/widgets/card_segment.dart';
import 'package:rapor_lc/app/widgets/searchbar.dart';
import 'package:rapor_lc/app/widgets/style.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/common/print_settings.dart';
import 'package:rapor_lc/data/repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/device/pdf/pages/root.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/dummy_data/dummies.dart' as d;

class AdminHomeDashboardUI extends View {
  AdminHomeDashboardUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeDashboardUIView();
}

class AdminHomeDashboardUIView
    extends ViewState<AdminHomeDashboardUI, AdminHomeDashboardController>
    with CustomWidgetStyle {

  AdminHomeDashboardUIView() : super(AdminHomeDashboardController(
    SantriRepositoryImpl(), NilaiRepositoryImpl(),
  ));

  @override
  Widget get view => Container(
    key: globalKey,
    child: ControlledWidgetBuilder<AdminHomeDashboardController>(
      builder: (context, controller) => CardSegment(
          icon: Icons.print, title: 'Print',
          columnItems: [
            // searchbar
            Searchbar(controller.tableOnSearch),

            // santri list is loading
            if (controller.santriState == RequestState.loading) Expanded(child: Center(child: CircularProgressIndicator())),
            // error raised when loading santri list or nilai list
            if (controller.santriState == RequestState.error || controller.nilaiState == RequestState.error) Expanded(child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Terjadi masalah saat memuat data.'),
                const SizedBox(height: 8.0),
                ElevatedButton.icon(
                  icon: Icon(Icons.refresh),
                  label: Text('Muat Ulang'),
                  onPressed: controller.onInitState,
                ),
              ],
            ))),
            // santri list is loaded, but no data
            if (controller.santriState == RequestState.none) Expanded(child: Center(child: Text('Belum ada santri di daftar.'))),
            // santri and nilai list is loaded
            if (controller.santriState == RequestState.loaded || controller.nilaiState == RequestState.loaded) Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Radio<int>(
                          value: 0,
                          groupValue: controller.tableRadioFilterValue,
                          onChanged: controller.tableRadioOnChanged,
                        ),
                        Text('Show All'),
                        const SizedBox(width: 8),
                        Radio<int>(
                          value: 1,
                          groupValue: controller.tableRadioFilterValue,
                          onChanged: controller.tableRadioOnChanged,
                        ),
                        Text('Show Selected'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        child: DataTable(
                          checkboxHorizontalMargin: 0,
                          columns: [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('NIS')),
                            DataColumn(label: Text('Nama')),
                            DataColumn(label: Text('')),
                          ],
                          rows: controller.filteredSantriList.map<DataRow>((e) => DataRow(
                            selected: controller.selectedSantriMap[e.id] ?? false,
                            onSelectChanged: (val) => controller.tableOnSelectChanged(e.id, val!),
                            cells: [
                              DataCell(Text('${e.id}')),
                              DataCell(Text('${e.nis}')),
                              DataCell(Text('${e.name}')),
                              DataCell(Container()),
                            ],
                          )).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Action Button
            SizedBox(
              height: 50.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      style: printBtnStyle,
                      icon: Icon(Icons.print),
                      label: Text('Print Rapor'),
                      onPressed: () => _printRapor(controller.getAllSelectedSantri(), controller.nilaiList ?? []),
                    ),
                  ),
                  SizedBox(width: 24.0),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton.icon(
                      style: printBtnStyle,
                      icon: Icon(Icons.print),
                      label: Text('Print Dummy Rapor'),
                      onPressed: _printDummyRapor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    ),
  );

  void _printRapor(List<Santri> allSelectedSantri, List<Nilai> allNilai) async {
    PrintSettings? printSetting;
    await showDialog<bool>(
      context: context,
      builder: (dContext) {
        return PrintDialog(
          onSave: (val) {
            printSetting = val;
          },
        );
      },
    );

    if (printSetting == null) return;

    final headerImage = pw.MemoryImage(
      (await rootBundle.load(printSetting!.imageAssetPath)).buffer.asUint8List(),
    );

    final doc = pw.Document();
    for (var santri in allSelectedSantri) {
      var santriNilaiList = allNilai.where((element) => element.santri == santri).toList();
      print('santri: ${santriNilaiList.length}');
      for (var i = printSetting!.fromSemester; i <= printSetting!.toSemester; ++i) {
        doc.addPage(page_nhb(headerImage, santriNilaiList, semester: i));
        doc.addPage(page_npb_chart(headerImage, santriNilaiList, semester: i));
        doc.addPage(page_npb_table(headerImage, santriNilaiList, semester: i));
        doc.addPage(page_npb_chart(headerImage, santriNilaiList, semester: i, isIT: true));
        doc.addPage(page_npb_table(headerImage, santriNilaiList, semester: i, isIT: true));
        doc.addPage(page_nk(headerImage, santriNilaiList, semester: i));
        doc.addPage(page_nk_advice(headerImage));
      }
    }

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  void _printDummyRapor() async {
    final headerImage = pw.MemoryImage(
        (await rootBundle.load('assets/images/rapor_header_qbs.png')).buffer.asUint8List(),
    );

    final doc = pw.Document();
    doc.addPage(page_title);
    doc.addPage(page_nhb(headerImage, [d.nilai_s_odd, d.nilai_s_even]));
    doc.addPage(page_npb_chart(headerImage, [d.nilai_s_odd, d.nilai_s_even]));
    doc.addPage(page_npb_table(headerImage, [d.nilai_s_odd, d.nilai_s_even]));
    doc.addPage(page_npb_chart(headerImage, [d.nilai_s_odd, d.nilai_s_even], isIT: true));
    doc.addPage(page_npb_table(headerImage, [d.nilai_s_odd, d.nilai_s_even], isIT: true));
    doc.addPage(page_nk(headerImage, [d.nilai_s_odd, d.nilai_s_even]));
    doc.addPage(page_nk_advice(headerImage));
    doc.addPage(page_nhb(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2));
    doc.addPage(page_npb_chart(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2));
    doc.addPage(page_npb_table(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2));
    doc.addPage(page_npb_chart(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2, isIT: true));
    doc.addPage(page_npb_table(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2, isIT: true));
    doc.addPage(page_nk(headerImage, [d.nilai_s_odd, d.nilai_s_even, d.nilai_s_even2, d.nilai_s_even3], semester: 2));
    doc.addPage(page_nk_advice(headerImage));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}