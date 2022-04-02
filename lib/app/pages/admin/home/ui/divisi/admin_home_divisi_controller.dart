
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/divisi_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/divisi_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/widgets/custom_datatable_controller.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/divisi/admin_home_divisi_presenter.dart';

class AdminHomeDivisiController extends DataTableController<Divisi> {
  final AdminHomeDivisiPresenter _presenter;
  AdminHomeDivisiController(divisiRepo)
      : _presenter = AdminHomeDivisiPresenter(divisiRepo),
        super();

  void _getDivisiList(List<Divisi> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getDivisiListState(RequestState state) {
    dataTableState = state;
    refreshUI();
  }

  void _createDivisiStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetDivisiList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal membuat Divisi.')));
  }

  void _updateDivisiStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetDivisiList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah Divisi.')));
  }

  void _deleteDivisiStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetDivisiList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus Divisi.')));
  }

  @override
  void initListeners() {
    _presenter.getDivisiList = _getDivisiList;
    _presenter.getDivisiListState = _getDivisiListState;
    _presenter.createDivisiStatus = _createDivisiStatus;
    _presenter.updateDivisiStatus = _updateDivisiStatus;
    _presenter.deleteDivisiStatus = _deleteDivisiStatus;
  }

  @override
  void refresh() => doGetDivisiList();

  void doGetDivisiList() => _presenter.doGetDivisiList();
  void doCreateDivisi(Divisi item) => _presenter.doCreateDivisi(item);
  void doUpdateDivisi(Divisi item) => _presenter.doUpdateDivisi(item);
  void doDeleteDivisi(List<String> nis) => _presenter.doDeleteDivisi(nis);

  @override
  void onInitState() {
    doGetDivisiList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget? createDialog() => DivisiCreateDialog(
    controller: this,
    onSave: (Divisi item) => doCreateDivisi(item),
  );

  @override
  Widget? updateDialog(Divisi? e) => DivisiUpdateDialog(
    divisi: e!,
    controller: this,
    onSave: (Divisi item) => doUpdateDivisi(item),
  );

  @override
  Widget? deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteDivisi(selected),
  );

  @override
  String getSelectedKey(Divisi e) => e.id.toString();

  @override
  bool searchWhereClause(Divisi e) {
    if (e.id.toString().contains(currentQuery)) return true;
    if (e.name.toLowerCase().contains(currentQuery)) return true;
    return false;
  }
}