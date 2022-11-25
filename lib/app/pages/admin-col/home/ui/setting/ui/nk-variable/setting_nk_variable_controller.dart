
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/nk_variable_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/nk_variable_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/ui/nk-variable/setting_nk_variable_presenter.dart';
import 'package:rapor_lc/app/subclasses/custom_datatable_controller.dart';
import 'package:rapor_lc/app/subclasses/lazy_controller_method.dart';
import 'package:rapor_lc/app/utils/constants.dart';
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

class SettingNKVariableController extends DataTableController<MataPelajaran> with LazyControllerMethod {
  final SettingNKVariablePresenter _presenter;
  final Function() _refreshSettingView;
  SettingNKVariableController(refreshFunc, mapelRepo, divisiRepo)
      : _presenter = SettingNKVariablePresenter(mapelRepo, divisiRepo),
        _refreshSettingView = refreshFunc,
        super();

  int _refreshCount = 0;

  void _getNKVariableList(List<MataPelajaran> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getNKVariableListState(RequestState state) {
    dataTableState = state;
    refreshUI();
    if (state == RequestState.loaded) {
      _refreshCount++;
      if (_refreshCount > 1) _refreshSettingView();
    }
  }

  void _getDivisiKesantrianState(RequestState state) {
    if (state == RequestState.none) {
      noDataMessage = Strings.nkSetupGuide;
      _getNKVariableListState(state);
      return;
    }
    else if (state == RequestState.loaded) {
      doGetNKVariableList();
    }
    else {
      _getNKVariableListState(state);
    }
  }

  @override
  void initListeners() {
    _presenter.getNKVariableList = _getNKVariableList;
    _presenter.getNKVariableListState = _getNKVariableListState;
    _presenter.createNKVariableStatus = (s) => onResponseStatus(getContext(), 'Create NK Variable', s, refresh);
    _presenter.updateNKVariableStatus = (s) => onResponseStatus(getContext(), 'Update NK Variable', s, refresh);
    _presenter.deleteNKVariableStatus = (s) => onResponseStatus(getContext(), 'Delete NK Variable', s, refresh);
    _presenter.getDivisiKesantrianState = _getDivisiKesantrianState;
  }

  @override
  void refresh() => _presenter.doGetNKVariableList();

  void doGetNKVariableList() {
    if (LoadedSettings.nkVariables != null) {
      _getNKVariableList(LoadedSettings.nkVariables!);
      _getNKVariableListState(RequestState.loaded);
    }
    else _presenter.doGetNKVariableList();
  }
  void doCreateNKVariable(MataPelajaran item) => _presenter.doCreateNKVariable(item);
  void doUpdateNKVariable(MataPelajaran item) => _presenter.doUpdateNKVariable(item);
  void doDeleteNKVariable(List<String> nis) => _presenter.doDeleteNKVariable(nis);
  void doGetDivisiKesantrian() => _presenter.doGetDivisiKesantrian();

  @override
  void onInitState() {
    if (LoadedSettings.divisiKesantrian != null) {
      doGetNKVariableList();
    }
    else {
      doGetDivisiKesantrian();
    }
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget? createDialog() => NKVariableCreateDialog(
    controller: this,
    onSave: (MataPelajaran item) => doCreateNKVariable(item),
  );

  @override
  Widget? updateDialog(MataPelajaran? e) => NKVariableUpdateDialog(
    nkVariable: e!,
    controller: this,
    onSave: (MataPelajaran item) => doUpdateNKVariable(item),
  );

  @override
  Widget? deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteNKVariable(selected),
  );

  @override
  String getSelectedKey(MataPelajaran e) => e.id.toString();

  @override
  bool searchWhereClause(MataPelajaran e) {
    if (e.id.toString().contains(currentQuery)) return true;
    if (e.name.toLowerCase().contains(currentQuery)) return true;
    if (e.divisi.name.toLowerCase().contains(currentQuery)) return true;
    return false;
  }
}