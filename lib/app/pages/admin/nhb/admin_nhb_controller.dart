
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/nhb_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/nhb_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/admin/nhb/admin_nhb_presenter.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/app/widgets/custom_datatable_controller.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class AdminNHBController extends DataTableController<NHB> {
  final Nilai _nilai;
  late final List<NHB> _nhbs;

  final AdminNHBPresenter _presenter;
  AdminNHBController(nilaiRepo, mapelRepo, nilai)
      : _presenter = AdminNHBPresenter(nilaiRepo, mapelRepo),
        _nilai = nilai,
        super();

  Future<List<MataPelajaran>>? mapelList;
  Future<List<MataPelajaran>> dialogOnFindMapel(String? query) async {
    mapelList ??= _presenter.futureGetMapelList();
    if (query == null || query == '') return mapelList!;

    return (await mapelList!).toList();
  }

  void _updateNilaiStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Berhasil mengubah NHB!')));
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah NHB.')));
  }

  @override
  void initListeners() {
    _presenter.updateNilaiStatus = _updateNilaiStatus;
  }

  @override
  void refresh() => doGetNHBList();

  void doGetNHBList() {
    dataTableState = RequestState.loaded;
    normalList = _nhbs;
    filteredList = _nhbs;
    selectedMap.addEntries(_nhbs.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
    refreshUI();
  }
  void doCreateNHB(NHB item) {
    _nhbs.add(item);
    refresh();
  }
  void doUpdateNHB(NHB item) {
    final index = _nhbs.indexWhere((element) => element.no == item.no);
    _nhbs.replaceRange(index, index+1, [item]);
    refresh();
  }
  void doDeleteNHB(List<String> nos) {
    _nhbs.removeWhere((element) => nos.contains(element.no.toString()));
    refresh();
  }
  void doUpdateNilai() {
    _nilai.nhb = _nhbs;
    _presenter.doUpdateNilai(_nilai);
  }

  @override
  void onInitState() {
    _nhbs = _nilai.nhb?.toList() ?? [];
    doGetNHBList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget? createDialog() => NHBCreateDialog(
    controller: this,
    onSave: (NHB item) => doCreateNHB(item),
  );

  @override
  Widget? updateDialog(NHB? e) => NHBUpdateDialog(
    nhb: e!,
    controller: this,
    onSave: (NHB item) => doUpdateNHB(item),
  );

  @override
  Widget? deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteNHB(selected),
  );

  @override
  String getSelectedKey(NHB e) => e.no.toString();

  @override
  bool searchWhereClause(NHB e) {
    if (e.no.toString().contains(currentQuery)) return true;
    if (e.pelajaran.name.toLowerCase().contains(currentQuery)) return true;
    if (e.nilai_harian.toString().contains(currentQuery)) return true;
    if (e.nilai_bulanan.toString().contains(currentQuery)) return true;
    if (e.nilai_projek.toString().contains(currentQuery)) return true;
    if (e.nilai_akhir.toString().contains(currentQuery)) return true;
    if (e.akumulasi.toString().contains(currentQuery)) return true;
    if (e.predikat.toLowerCase().contains(currentQuery)) return true;
    return false;
  }
}