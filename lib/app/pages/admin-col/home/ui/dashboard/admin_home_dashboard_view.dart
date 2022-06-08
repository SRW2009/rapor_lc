
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/dialogs/common/logs_dialog.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/dashboard/admin_home_dashboard_controller.dart';
import 'package:rapor_lc/app/widgets/card_segment.dart';
import 'package:rapor_lc/app/widgets/searchbar.dart';
import 'package:rapor_lc/app/widgets/style.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/data/repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/device/excel/repository/excel_repo_impl.dart';
import 'package:rapor_lc/device/pdf/repositories/printing_repo_impl.dart';

class AdminHomeDashboardUI extends View {
  AdminHomeDashboardUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeDashboardUIView();
}

class AdminHomeDashboardUIView
    extends ViewState<AdminHomeDashboardUI, AdminHomeDashboardController>
    with CustomWidgetStyle {

  ScrollController mainScrollController = ScrollController();
  ScrollController printScrollController = ScrollController();

  AdminHomeDashboardUIView() : super(AdminHomeDashboardController(
    SantriRepositoryImpl(), NilaiRepositoryImpl(),
    PrintingRepositoryImpl(), ExcelRepositoryImpl(),
  ));

  @override
  Widget get view => Container(
    key: globalKey,
    child: ControlledWidgetBuilder<AdminHomeDashboardController>(
      builder: (context, controller) => Stack(
        children: [
          // dashboard content
          Positioned.fill(
            child: ListView(
              controller: mainScrollController,
              children: [
                // Print Segment
                SizedBox(
                  height: MediaQuery.of(context).size.height*.7,
                  child: CardSegment(
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
                            padding: EdgeInsets.only(top: 10, bottom: 20),
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
                                    controller: printScrollController,
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
                          height: 45.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 2,
                                child: ElevatedButton.icon(
                                  style: dashboardBtnStyle,
                                  icon: Icon(Icons.print),
                                  label: Text('Print Rapor'),
                                  onPressed: () => controller.print(controller.getAllSelectedSantri(), controller.nilaiList ?? []),
                                ),
                              ),
                              SizedBox(width: 24.0),
                              Expanded(
                                flex: 1,
                                child: OutlinedButton.icon(
                                  style: dashboardBtnStyle,
                                  icon: Icon(Icons.print),
                                  label: Text('Print Dummy Rapor'),
                                  onPressed: controller.printDummy,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
                // Import Segment
                CardSegment(
                  icon: Icons.input,
                  title: 'Impor Nilai',
                  columnItems: [
                    // Action Button
                    SizedBox(
                      height: 45.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 2,
                            child: ElevatedButton.icon(
                              style: dashboardBtnStyle,
                              icon: Icon(Icons.input),
                              label: Text('Pilih File...'),
                              onPressed: controller.import,
                            ),
                          ),
                          SizedBox(width: 24.0),
                          Expanded(
                            flex: 1,
                            child: OutlinedButton.icon(
                              style: dashboardBtnStyle,
                              icon: Icon(Icons.input),
                              label: Text('Download File Template'),
                              onPressed: controller.saveImportSample,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CardSegment(
                  icon: Icons.output,
                  title: 'Expor Nilai',
                  columnItems: [
                    // Action Button
                    SizedBox(
                      height: 45.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: dashboardBtnStyle,
                              icon: Icon(Icons.output),
                              label: Text('Expor Nilai'),
                              onPressed: controller.export,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // logs dialog
          IgnorePointer(
            ignoring: !controller.showLogsDialog,
            child: Opacity(
              opacity: (controller.showLogsDialog) ? 1 : 0,
              child: Container(
                color: Colors.black38,
                child: LogsDialog(
                  key: controller.dialogKey,
                  onClose: controller.closeLogsDialog,
                ),
              ),
            ),
          ),
        ],
      )
    ),
  );
}