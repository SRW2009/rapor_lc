
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/client/nilai_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/client/nilai_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/client-col/manage-nilai/manage_nilai_presenter.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/app/subclasses/custom_datatable_controller.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class ManageNilaiController extends DataTableController<Nilai> {
  final Santri santri;

  final ManageNilaiPresenter _presenter;
  ManageNilaiController(nilaiRepo, this.santri)
      : _presenter = ManageNilaiPresenter(nilaiRepo);

  void _getNilaiList(List<Nilai> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getNilaiListState(RequestState state) {
    dataTableState = state;
    refreshUI();
  }

  void _reqNilaiStatus(RequestStatus status, String actionMessage) {
    if (status == RequestStatus.success) {
      doGetNilaiList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(SnackBar(content: Text('Gagal $actionMessage Nilai.')));
  }
  
  @override
  void initListeners() {
    _presenter.getNilaiList = _getNilaiList;
    _presenter.getNilaiListState = _getNilaiListState;
    _presenter.createNilaiStatus = (status) => _reqNilaiStatus(status, 'membuat');
    _presenter.updateNilaiStatus = (status) => _reqNilaiStatus(status, 'mengubah');
    _presenter.deleteNilaiStatus = (status) => _reqNilaiStatus(status, 'menghapus');
  }

  @override
  void onInitState() {
    refresh();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  void refresh() => doGetNilaiList();

  void doGetNilaiList() => _presenter.doGetNilaiList(santri.id);
  void doCreateNilai(Nilai item) => _presenter.doCreateNilai(item);
  void doUpdateNilai(Nilai item) => _presenter.doUpdateNilai(item);
  void doDeleteNilai(List<String> nis) => _presenter.doDeleteNilai(nis);

  void onTapNHBSemester(Nilai item) async {
    await Navigator.of(getContext())
        .pushNamed(Pages.manage_nhb_semester, arguments: item);
    refresh();
  }

  void onTapNHBBlock(Nilai item) async {
    await Navigator.of(getContext())
        .pushNamed(Pages.manage_nhb_block, arguments: item);
    refresh();
  }

  void onTapNK(Nilai item) async {
    await Navigator.of(getContext())
        .pushNamed(Pages.manage_nk, arguments: item);
    refresh();
  }

  void onTapNPB(Nilai item) async {
    await Navigator.of(getContext())
        .pushNamed(Pages.manage_npb, arguments: item);
    refresh();
  }

  @override
  Widget? createDialog() => ClientNilaiCreateDialog(
    santri: santri,
    onSave: (item) => doCreateNilai(item),
  );

  @override
  Widget? updateDialog(Nilai? e) => ClientNilaiUpdateDialog(
    nilai: e!,
    onSave: (item) => doUpdateNilai(item),
  );

  @override
  Widget? deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteNilai(selected),
  );

  @override
  String getSelectedKey(Nilai e) => e.id.toString();

  @override
  bool searchWhereClause(Nilai e) {
    return e.timeline.toExcelString().toLowerCase().contains(currentQuery)
        || e.tahunAjaran.toLowerCase().contains(currentQuery);
  }
}