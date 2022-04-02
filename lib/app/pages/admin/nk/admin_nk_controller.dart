
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/nk_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/nk_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/admin/nk/admin_nk_presenter.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/app/widgets/custom_datatable_controller.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class AdminNKController extends DataTableController<NK> {
  late final Nilai _nilai;
  late final List<NK> _nks;

  final AdminNKPresenter _presenter;
  AdminNKController(nilaiRepo, mapelRepo, nilai)
      : _presenter = AdminNKPresenter(nilaiRepo, mapelRepo),
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
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Berhasil mengubah NK!')));
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah NK.')));
  }

  @override
  void initListeners() {
    _presenter.updateNilaiStatus = _updateNilaiStatus;
  }

  @override
  void refresh() => doGetNKList();

  void doGetNKList() {
    dataTableState = RequestState.loaded;
    normalList = _nks;
    filteredList = _nks;
    selectedMap.addEntries(_nks.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
    refreshUI();
  }
  void doCreateNK(NK item) {
    _nks.add(item);
    refresh();
  }
  void doUpdateNK(NK item) {
    final index = _nks.indexWhere((element) => element.no == item.no);
    _nks.replaceRange(index, index+1, [item]);
    refresh();
  }
  void doDeleteNK(List<String> nos) {
    _nks.removeWhere((element) => nos.contains(element.no.toString()));
    refresh();
  }
  void doUpdateNilai() {
    _nilai.nk = _nks;
    _presenter.doUpdateNilai(_nilai);
  }

  @override
  void onInitState() {
    _nks = _nilai.nk?.toList() ?? [];
    doGetNKList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget? createDialog() => NKCreateDialog(
    controller: this,
    onSave: (NK item) => doCreateNK(item),
  );

  @override
  Widget? updateDialog(NK? e) => NKUpdateDialog(
    nk: e!,
    controller: this,
    onSave: (NK item) => doUpdateNK(item),
  );

  @override
  Widget? deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteNK(selected),
  );

  @override
  String getSelectedKey(NK e) => e.no.toString();

  @override
  bool searchWhereClause(NK e) {
    if (e.no.toString().contains(currentQuery)) return true;
    if (e.nama_variabel.toLowerCase().contains(currentQuery)) return true;
    if (e.nilai_mesjid.toString().contains(currentQuery)) return true;
    if (e.nilai_asrama.toString().contains(currentQuery)) return true;
    if (e.nilai_kelas.toString().contains(currentQuery)) return true;
    if (e.akumulatif.toString().contains(currentQuery)) return true;
    if (e.predikat.toLowerCase().contains(currentQuery)) return true;
    return false;
  }
}