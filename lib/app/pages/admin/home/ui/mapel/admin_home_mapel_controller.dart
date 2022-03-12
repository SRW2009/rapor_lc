
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/mapel_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/mapel_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/base_datatable_controller.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/mapel/admin_home_mapel_presenter.dart';

class AdminHomeMataPelajaranController extends DataTableController<MataPelajaran> {
  final AdminHomeMataPelajaranPresenter _presenter;
  AdminHomeMataPelajaranController(mapelRepo, divisiRepo)
      : _presenter = AdminHomeMataPelajaranPresenter(mapelRepo, divisiRepo),
        super();

  Future<List<Divisi>>? divisiList;
  Future<List<Divisi>> dialogOnFindDivisi(String? query) async {
    divisiList ??= _presenter.futureGetDivisiList();
    if (query == null || query == '') return divisiList!;

    return (await divisiList!)
        .where((element) => element.nama.toLowerCase().contains(query))
        .toList();
  }

  void _getMataPelajaranList(List<MataPelajaran> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getMataPelajaranListState(RequestState state) {
    dataTableState = state;
    refreshUI();
  }

  void _createMataPelajaranStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetMataPelajaranList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal membuat MataPelajaran.')));
  }

  void _updateMataPelajaranStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetMataPelajaranList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah MataPelajaran.')));
  }

  void _deleteMataPelajaranStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetMataPelajaranList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus MataPelajaran.')));
  }

  @override
  void initListeners() {
    _presenter.getMataPelajaranList = _getMataPelajaranList;
    _presenter.getMataPelajaranListState = _getMataPelajaranListState;
    _presenter.createMataPelajaranStatus = _createMataPelajaranStatus;
    _presenter.updateMataPelajaranStatus = _updateMataPelajaranStatus;
    _presenter.deleteMataPelajaranStatus = _deleteMataPelajaranStatus;
  }

  @override
  void refresh() => doGetMataPelajaranList();

  void doGetMataPelajaranList() => _presenter.doGetMataPelajaranList();
  void doCreateMataPelajaran(MataPelajaran item) => _presenter.doCreateMataPelajaran(item);
  void doUpdateMataPelajaran(MataPelajaran item) => _presenter.doUpdateMataPelajaran(item);
  void doDeleteMataPelajaran(List<String> nis) => _presenter.doDeleteMataPelajaran(nis);

  @override
  void onInitState() {
    doGetMataPelajaranList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget createDialog() => MataPelajaranCreateDialog(
    controller: this,
    onSave: (MataPelajaran item) => doCreateMataPelajaran(item),
  );

  @override
  Widget updateDialog(MataPelajaran e) => MataPelajaranUpdateDialog(
    mataPelajaran: e,
    controller: this,
    onSave: (MataPelajaran item) => doUpdateMataPelajaran(item),
  );

  @override
  Widget deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteMataPelajaran(selected),
  );

  @override
  String getSelectedKey(MataPelajaran e) => e.id.toString();

  @override
  bool searchWhereClause(MataPelajaran e) {
    if (e.id.toString().contains(currentQuery)) return true;
    if (e.divisi.nama.toLowerCase().contains(currentQuery)) return true;
    if (e.nama_mapel.toLowerCase().contains(currentQuery)) return true;
    return false;
  }
}