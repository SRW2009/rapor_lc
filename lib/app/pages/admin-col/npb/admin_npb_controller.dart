
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/npb_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/npb_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/admin-col/npb/admin_npb_presenter.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/app/widgets/custom_datatable_controller.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class AdminNPBController extends DataTableController<NPB> {
  final Nilai _nilai;
  late final List<NPB> _npbs;

  final AdminNPBPresenter _presenter;
  AdminNPBController(nilaiRepo, mapelRepo, nilai)
      : _presenter = AdminNPBPresenter(nilaiRepo, mapelRepo),
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
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Berhasil mengubah NPB!')));
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah NPB.')));
  }

  @override
  void initListeners() {
    _presenter.updateNilaiStatus = _updateNilaiStatus;
  }

  @override
  void refresh() => doGetNPBList();

  void doGetNPBList() {
    dataTableState = RequestState.loaded;
    normalList = _npbs;
    filteredList = _npbs;
    selectedMap.addEntries(_npbs.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
    refreshUI();
  }
  void doCreateNPB(NPB item) {
    _npbs.add(item);
    refresh();
  }
  void doUpdateNPB(NPB item) {
    final index = _npbs.indexWhere((element) => element.no == item.no);
    _npbs.replaceRange(index, index+1, [item]);
    refresh();
  }
  void doDeleteNPB(List<String> nos) {
    _npbs.removeWhere((element) => nos.contains(element.no.toString()));
    refresh();
  }
  void doUpdateNilai() {
    _nilai.npb = _npbs;
    _presenter.doUpdateNilai(_nilai);
  }

  @override
  void onInitState() {
    _npbs = _nilai.npb?.toList() ?? [];
    doGetNPBList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget? createDialog() => NPBCreateDialog(
    controller: this,
    onSave: (NPB item) => doCreateNPB(item),
  );

  @override
  Widget? updateDialog(NPB? e) => NPBUpdateDialog(
    npb: e!,
    controller: this,
    onSave: (NPB item) => doUpdateNPB(item),
  );

  @override
  Widget? deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteNPB(selected),
  );

  @override
  String getSelectedKey(NPB e) => e.no.toString();

  @override
  bool searchWhereClause(NPB e) {
    if (e.no.toString().contains(currentQuery)) return true;
    if (e.pelajaran.name.toLowerCase().contains(currentQuery)) return true;
    if (e.presensi.toLowerCase().contains(currentQuery)) return true;
    if (e.n.toString().contains(currentQuery)) return true;
    return false;
  }
}