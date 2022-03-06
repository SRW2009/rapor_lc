
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/base_datatable_controller.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/npb/admin_home_npb_presenter.dart';

class AdminHomeNPBController extends DataTableController<NPB> {
  RequestState dataState = RequestState.none;

  final AdminHomeNPBPresenter _presenter;
  AdminHomeNPBController(npbRepo, santriRepo, mapelRepo)
      : _presenter = AdminHomeNPBPresenter(npbRepo, santriRepo, mapelRepo),
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

  void _getNPBList(List<NPB> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getNPBListState(RequestState state) {
    dataState = state;
    refreshUI();
  }

  void _createNPBStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetNPBList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal membuat NPB.')));
  }

  void _updateNPBStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetNPBList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah NPB.')));
  }

  void _deleteNPBStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetNPBList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus NPB.')));
  }

  @override
  void initListeners() {
    _presenter.getNPBList = _getNPBList;
    _presenter.getNPBListState = _getNPBListState;
    _presenter.createNPBStatus = _createNPBStatus;
    _presenter.updateNPBStatus = _updateNPBStatus;
    _presenter.deleteNPBStatus = _deleteNPBStatus;
  }

  void doGetNPBList() => _presenter.doGetNPBList();
  void doCreateNPB(NPB item) => _presenter.doCreateNPB(item);
  void doUpdateNPB(NPB item) => _presenter.doUpdateNPB(item);
  void doDeleteNPB(List<String> nis) => _presenter.doDeleteNPB(nis);

  @override
  void onInitState() {
    doGetNPBList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget createDialog() => Container();/*NPBCreateDialog(
    controller: this,
    onSave: (NPB item) => doCreateNPB(item),
  );*/

  @override
  Widget updateDialog(NPB e) => Container();/*NPBUpdateDialog(
    npb: e,
    controller: this,
    onSave: (NPB item) => doUpdateNPB(item),
  );*/

  @override
  Widget deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteNPB(selected),
  );

  @override
  String getSelectedKey(NPB e) => e.id.toString();

  @override
  bool searchWhereClause(NPB e) {
    if (e.id.toString().contains(currentQuery)) return true;
    if (e.santri.nama.toLowerCase().contains(currentQuery)) return true;
    if (e.semester.toString().contains(currentQuery)) return true;
    if (e.tahunAjaran.toLowerCase().contains(currentQuery)) return true;
    if (e.pelajaran.namaMapel.toLowerCase().contains(currentQuery)) return true;
    if (e.presensi.toLowerCase().contains(currentQuery)) return true;
    return false;
  }
}