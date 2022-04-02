
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/widgets/custom_datatable_controller.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/app/pages/client/home/ui/santri/home_santri_presenter.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class HomeSantriController extends DataTableController<Santri> {
  final HomeSantriPresenter _presenter;
  HomeSantriController(divisiRepo)
      : _presenter = HomeSantriPresenter(divisiRepo),
        super();

  void _getSantriList(List<Santri> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getSantriListState(RequestState state) {
    dataTableState = state;
    refreshUI();
  }

  void _createSantriStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetSantriList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal membuat Santri.')));
  }

  void _updateSantriStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetSantriList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah Santri.')));
  }

  void _deleteSantriStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetSantriList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus Santri.')));
  }

  @override
  void initListeners() {
    _presenter.getSantriList = _getSantriList;
    _presenter.getSantriListState = _getSantriListState;
    _presenter.createSantriStatus = _createSantriStatus;
    _presenter.updateSantriStatus = _updateSantriStatus;
    _presenter.deleteSantriStatus = _deleteSantriStatus;
  }

  @override
  void refresh() => doGetSantriList();

  void doGetSantriList() => _presenter.doGetSantriList();
  void doCreateSantri(Santri item) => _presenter.doCreateSantri(item);
  void doUpdateSantri(Santri item) => _presenter.doUpdateSantri(item);
  void doDeleteSantri(List<String> nis) => _presenter.doDeleteSantri(nis);

  @override
  void onInitState() {
    doGetSantriList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget? createDialog() => null;

  @override
  Widget? updateDialog(Santri? e) => null;

  @override
  Widget? deleteDialog(List<String> selected) => null;

  @override
  String getSelectedKey(Santri e) => e.id.toString();

  @override
  bool searchWhereClause(Santri e) {
    if (e.id.toString().contains(currentQuery)) return true;
    if (e.name.toLowerCase().contains(currentQuery)) return true;
    if (e.kadiv.toLowerCase().contains(currentQuery)) return true;
    return false;
  }
}