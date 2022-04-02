
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/nilai_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/nilai_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nilai/admin_home_nilai_presenter.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/app/widgets/custom_datatable_controller.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class AdminHomeNilaiController extends DataTableController<Nilai> {
  final AdminHomeNilaiPresenter _presenter;
  AdminHomeNilaiController(nilaiRepo, santriRepo)
      : _presenter = AdminHomeNilaiPresenter(nilaiRepo, santriRepo),
        super();

  Future<List<Santri>>? santriList;
  Future<List<Santri>> dialogOnFindSantri(String? query) async {
    santriList ??= _presenter.futureGetSantriList();
    if (query == null || query == '') return santriList!;

    return (await santriList!).toList();
  }

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

  void _createNilaiStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetNilaiList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal membuat Nilai.')));
  }

  void _updateNilaiStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetNilaiList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah Nilai.')));
  }

  void _deleteNilaiStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetNilaiList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus Nilai.')));
  }

  @override
  void initListeners() {
    _presenter.getNilaiList = _getNilaiList;
    _presenter.getNilaiListState = _getNilaiListState;
    _presenter.createNilaiStatus = _createNilaiStatus;
    _presenter.updateNilaiStatus = _updateNilaiStatus;
    _presenter.deleteNilaiStatus = _deleteNilaiStatus;
  }

  @override
  void refresh() => doGetNilaiList();

  void doGetNilaiList() => _presenter.doGetNilaiList();
  void doCreateNilai(Nilai item) => _presenter.doCreateNilai(item);
  void doUpdateNilai(Nilai item) => _presenter.doUpdateNilai(item);
  void doDeleteNilai(List<String> nis) => _presenter.doDeleteNilai(nis);

  @override
  void onInitState() {
    doGetNilaiList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  tableOnMore(Nilai nilai, Type arg) {
    if (arg == NHB) {
      Navigator.of(getContext())
          .pushNamed(Pages.admin_manage_nilai_nhb, arguments: nilai);
    }
    if (arg == NK) {
      Navigator.of(getContext())
          .pushNamed(Pages.admin_manage_nilai_nk, arguments: nilai);
    }
    if (arg == NPB) {
      Navigator.of(getContext())
          .pushNamed(Pages.admin_manage_nilai_npb, arguments: nilai);
    }
  }

  @override
  Widget? createDialog() => NilaiCreateDialog(
    controller: this,
    onSave: (Nilai item) => doCreateNilai(item),
  );

  @override
  Widget? updateDialog(Nilai? e) => NilaiUpdateDialog(
    nilai: e!,
    controller: this,
    onSave: (Nilai item) => doUpdateNilai(item),
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
    if (e.id.toString().contains(currentQuery)) return true;
    if (e.BaS.toReadableString().toLowerCase().contains(currentQuery)) return true;
    if (e.tahunAjaran.toLowerCase().contains(currentQuery)) return true;
    if (e.santri.name.toLowerCase().contains(currentQuery)) return true;
    return false;
  }
}