
import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/admin_home_setting_controller.dart';
import 'package:rapor_lc/app/subclasses/custom_datatable_controller.dart';
import 'package:rapor_lc/app/utils/constants.dart';
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/domain/entities/setting.dart';

class SettingNKEnabledGradeController extends DataTableController<NKEnabledGradeTypeEntry> {
  SettingNKEnabledGradeController() : super();

  bool hasChanged = false;

  updateItem(NKEnabledGradeTypeEntry item, String gradeType, bool val) {
    final ref = normalList.firstWhere((element) => element.key == item.key);
    ref.value[gradeType] = val;

    try {
      final ref2 = filteredList.firstWhere((element) => element.key == item.key);
      ref2.value[gradeType] = val;
    } on StateError {}

    hasChanged = true;
    refreshUI();
  }

  void onDiscard() {
    refresh();
  }

  void onSave(AdminHomeSettingController parentController) {
    final list = normalList;

    if (LoadedSettings.nkEnabledGradeId == -1) {
      parentController.createSetting(Setting(
        0,
        SettingVariables.nkEnabledGrade,
        LoadedSettings.nkEnabledGradeConvertToMap(list),
      ));
    } else {
      parentController.updateSetting(Setting(
        LoadedSettings.nkEnabledGradeId,
        SettingVariables.nkEnabledGrade,
        LoadedSettings.nkEnabledGradeConvertToMap(list),
      ));
    }
  }

  @override
  void onInitState() {
    dataTableState = RequestState.loading;
    refreshUI();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (LoadedSettings.nkVariables != null) {
        if (LoadedSettings.nkEnabledGrade == null) LoadedSettings.nkEnabledGrade = {};
        refresh();
        timer.cancel();
      }
    });
  }

  @override
  void initListeners() {}

  @override
  void onDisposed() {
    super.onDisposed();
  }

  @override
  Widget? createDialog() => null;

  @override
  Widget? deleteDialog(List<String> selected) => null;

  @override
  String getSelectedKey(NKEnabledGradeTypeEntry e) => e.key;

  @override
  void refresh() {
    final list = LoadedSettings.getNkEnabledGradeEntries()!;
    normalList = list;
    filteredList = list;
    dataTableState = RequestState.loaded;
    hasChanged = false;
    refreshUI();
  }

  @override
  bool searchWhereClause(NKEnabledGradeTypeEntry e) =>
      e.key.contains(currentQuery);

  @override
  Widget? updateDialog(NKEnabledGradeTypeEntry? e) => null;
}