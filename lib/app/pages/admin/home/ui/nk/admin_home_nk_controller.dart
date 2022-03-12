
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/nk_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/nk_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/base_datatable_controller.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nk/admin_home_nk_presenter.dart';

class AdminHomeNKController extends DataTableController<NK> {
  final AdminHomeNKPresenter _presenter;
  AdminHomeNKController(nkRepo, santriRepo)
      : _presenter = AdminHomeNKPresenter(nkRepo, santriRepo),
        super();

  Future<List<Santri>>? santriList;
  Future<List<Santri>> dialogOnFindSantri(String? query) async {
    santriList ??= _presenter.futureGetSantriList();
    if (query == null || query == '') return santriList!;

    return (await santriList!)
        .where((element) => element.nama.toLowerCase().contains(query))
        .toList();
  }

  void _getNKList(List<NK> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getNKListState(RequestState state) {
    dataTableState = state;
    refreshUI();
  }

  void _createNKStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetNKList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal membuat NK.')));
  }

  void _updateNKStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetNKList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah NK.')));
  }

  void _deleteNKStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetNKList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus NK.')));
  }

  @override
  void initListeners() {
    _presenter.getNKList = _getNKList;
    _presenter.getNKListState = _getNKListState;
    _presenter.createNKStatus = _createNKStatus;
    _presenter.updateNKStatus = _updateNKStatus;
    _presenter.deleteNKStatus = _deleteNKStatus;
  }

  @override
  void refresh() => doGetNKList();

  void doGetNKList() => _presenter.doGetNKList();
  void doCreateNK(NK item) => _presenter.doCreateNK(item);
  void doUpdateNK(NK item) => _presenter.doUpdateNK(item);
  void doDeleteNK(List<String> nis) => _presenter.doDeleteNK(nis);

  @override
  void onInitState() {
    doGetNKList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget createDialog() => NKCreateDialog(
    controller: this,
    onSave: (NK item) => doCreateNK(item),
  );

  @override
  Widget updateDialog(NK e) => NKUpdateDialog(
    nk: e,
    controller: this,
    onSave: (NK item) => doUpdateNK(item),
  );

  @override
  Widget deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteNK(selected),
  );

  @override
  String getSelectedKey(NK e) => e.id.toString();

  @override
  bool searchWhereClause(NK e) {
    if (e.id.toString().contains(currentQuery)) return true;
    if (e.santri.nama.toLowerCase().contains(currentQuery)) return true;
    if (e.semester.toString().contains(currentQuery)) return true;
    if (e.tahun_ajaran.toLowerCase().contains(currentQuery)) return true;
    if (e.bulan.toString().contains(currentQuery)) return true;
    if (e.nama_variabel.toLowerCase().contains(currentQuery)) return true;
    if (e.nilai_mesjid.toString().contains(currentQuery)) return true;
    if (e.nilai_kelas.toString().contains(currentQuery)) return true;
    if (e.nilai_asrama.toString().contains(currentQuery)) return true;
    if (e.akumulatif.toString().contains(currentQuery)) return true;
    if (e.predikat.toLowerCase().contains(currentQuery)) return true;
    return false;
  }
}