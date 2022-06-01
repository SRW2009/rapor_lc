
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/dialogs/admin/print_dialog.dart';
import 'package:rapor_lc/app/dialogs/common/logs_dialog.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/dashboard/admin_home_dashboard_presenter.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/common/print_settings.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class AdminHomeDashboardController extends Controller {
  List<Santri> santriList = [];
  List<Santri> filteredSantriList = [];
  Map<int, bool> selectedSantriMap = {};
  RequestState santriState = RequestState.none;

  List<Nilai>? nilaiList;
  RequestState nilaiState = RequestState.none;

  final dialogKey = GlobalKey<LogsDialogState>();
  bool showLogsDialog = false;

  final AdminHomeDashboardPresenter _presenter;
  AdminHomeDashboardController(santriRepository, nilaiRepository, printingRepository, excelRepository)
      : _presenter = AdminHomeDashboardPresenter(santriRepository, nilaiRepository, printingRepository, excelRepository),
        super();

  void _getSantriList(List<Santri> list) {
    santriList = list;
    filteredSantriList = list.cast();
  }

  void _getSantriListState(RequestState state) {
    santriState = state;
    refreshUI();
  }

  void _getNilaiList(List<Nilai> list) {
    nilaiList = list;
  }

  void _getNilaiListState(RequestState state) {
    nilaiState = state;
    refreshUI();
  }
  void _printExceptionMessage(String message) {
    if (dialogKey.currentState != null)
      dialogKey.currentState!.addLine(message);
    refreshUI();
  }

  @override
  void initListeners() {
    _presenter.getSantriList = _getSantriList;
    _presenter.getSantriListState = _getSantriListState;
    _presenter.getNilaiList = _getNilaiList;
    _presenter.getNilaiListState = _getNilaiListState;
    _presenter.printExceptionMessage = _printExceptionMessage;
  }

  void getSantriList() {
    santriState = RequestState.loading;
    refreshUI();
    _presenter.doGetSantriList();
  }
  void getNilaiList() {
    nilaiState = RequestState.loading;
    refreshUI();
    _presenter.doGetNilaiList();
  }
  void print(List<Santri> santriList, List<Nilai> nilaiList) async {
    // show print settings dialog
    PrintSettings? printSettings;
    await showDialog<bool>(
      context: getContext(),
      builder: (dContext) {
        return PrintDialog(
          onSave: (val) {
            printSettings = val;
          },
        );
      },
    );
    // return if canceled
    if (printSettings == null) return;
    // show logs dialog
    dialogKey.currentState?.updateLog('');
    showLogsDialog = true;
    refreshUI();
    // do print
    _presenter.doPrint(santriList, nilaiList, printSettings);
  }
  void printDummy() => _presenter.doPrintDummy();
  void import() async {
    // pick files
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (result != null) {
      List<File> files = result.paths.fold<List<File>>([], (list, path) {
        if (path != null) list.add(File(path));
        return list;
      });
      // show logs dialog
      dialogKey.currentState?.updateLog('');
      showLogsDialog = true;
      refreshUI();
      // do import
      _presenter.doImport(files);
    }
  }
  void saveImportSample() async {
    ByteData data = await rootBundle.load("assets/files/import_example.xlsx");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    String? selectedDirectory = await FilePicker.platform.saveFile(
      fileName: 'import-example.xlsx',
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (selectedDirectory != null) {
      await File(selectedDirectory).writeAsBytes(bytes);
    }
  }

  @override
  void onInitState() {
    getSantriList();
    getNilaiList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void closeLogsDialog() {
    showLogsDialog = false;
    refreshUI();
  }

  String currentQuery = '';
  void tableOnSearch(String q) {
    var query = q.toLowerCase();
    if (currentQuery == query) return;
    currentQuery = query;

    filteredSantriList = (query == '')
        ? santriList.cast()
        : santriList.where((e) =>
            e.id.toString().contains(query)
            || (e.nis?.contains(query) ?? false)
            || e.name.toLowerCase().contains(query)
    ).toList();
    refreshUI();
  }

  void tableOnSelectChanged(int id, bool val) {
    selectedSantriMap[id] = val;
    refreshUI();
  }

  int tableRadioFilterValue = 0;
  void tableRadioOnChanged(int? value) {
    if (value == null) return;
    currentQuery = '';
    tableRadioFilterValue = value;
    if (value == 0) {
      filteredSantriList = santriList.cast();
    }
    else {
      filteredSantriList = getAllSelectedSantri();
    }
    refreshUI();
  }

  List<Santri> getAllSelectedSantri() => santriList.where((e) => selectedSantriMap[e.id] ?? false).toList();
}