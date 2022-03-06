
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/base_datatable_controller.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

import 'admin_home_nhb_presenter.dart';

class AdminHomeNHBController extends DataTableController<NHB> {
  RequestState dataState = RequestState.none;

  final AdminHomeNHBPresenter _presenter;
  AdminHomeNHBController(nhbRepo, santriRepo, mapelRepo)
      : _presenter = AdminHomeNHBPresenter(nhbRepo, santriRepo, mapelRepo),
        super();

  Future<List<Santri>>? santriList;
  Future<List<Santri>> dialogOnFindSantri(String? query) async {
    santriList ??= _presenter.futureGetSantriList();
    if (query == null || query == '') return santriList!;

    return (await santriList!)
        .where((element) => element.nama.toLowerCase().contains(query))
        .toList();
  }

  Future<List<MataPelajaran>>? mapelList;
  Future<List<MataPelajaran>> dialogOnFindMapel(String? query) async {
    mapelList ??= _presenter.futureGetMapelList();
    if (query == null || query == '') return mapelList!;

    return (await mapelList!)
        .where((element) => element.namaMapel.toLowerCase().contains(query))
        .toList();
  }

  void _getNHBList(List<NHB> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getNHBListState(RequestState state) {
    dataState = state;
    refreshUI();
  }

  void _createNHBStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetNHBList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal membuat NHB.')));
  }

  void _updateNHBStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetNHBList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah NHB.')));
  }

  void _deleteNHBStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetNHBList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus NHB.')));
  }

  @override
  void initListeners() {
    _presenter.getNHBList = _getNHBList;
    _presenter.getNHBListState = _getNHBListState;
    _presenter.createNHBStatus = _createNHBStatus;
    _presenter.updateNHBStatus = _updateNHBStatus;
    _presenter.deleteNHBStatus = _deleteNHBStatus;
  }

  void doGetNHBList() => _presenter.doGetNHBList();
  void doCreateNHB(NHB item) => _presenter.doCreateNHB(item);
  void doUpdateNHB(NHB item) => _presenter.doUpdateNHB(item);
  void doDeleteNHB(List<String> nis) => _presenter.doDeleteNHB(nis);

  @override
  void onInitState() {
    doGetNHBList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget createDialog() => Container();/*NHBCreateDialog(
    controller: this,
    onSave: (NHB item) => doCreateNHB(item),
  );*/

  @override
  Widget updateDialog(NHB e) => Container();/*NHBUpdateDialog(
    nhb: e,
    controller: this,
    onSave: (NHB item) => doUpdateNHB(item),
  );*/

  @override
  Widget deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteNHB(selected),
  );

  @override
  String getSelectedKey(NHB e) => e.id.toString();

  @override
  bool searchWhereClause(NHB e) {
    if (e.id.toString().contains(currentQuery)) return true;
    if (e.santri.nama.toLowerCase().contains(currentQuery)) return true;
    if (e.semester.toString().contains(currentQuery)) return true;
    if (e.tahunAjaran.toLowerCase().contains(currentQuery)) return true;
    if (e.mataPelajaran.namaMapel.toLowerCase().contains(currentQuery)) return true;
    if (e.nilaiHarian.toString().contains(currentQuery)) return true;
    if (e.nilaiBulanan.toString().contains(currentQuery)) return true;
    if (e.nilaiProject.toString().contains(currentQuery)) return true;
    if (e.nilaiAkhir.toString().contains(currentQuery)) return true;
    if (e.akumulasi.toString().contains(currentQuery)) return true;
    if (e.predikat.toLowerCase().contains(currentQuery)) return true;
    return false;
  }
}