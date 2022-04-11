
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/client/npb_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/client/npb_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/client-col/manage-npb/manage_npb_presenter.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/app/widgets/custom_datatable_controller.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class ManageNPBController extends DataTableController<NPB> {
  final Nilai nilai;

  final ManageNPBPresenter _presenter;
  ManageNPBController(nilaiRepo, mapelRepo, this.nilai)
      : _presenter = ManageNPBPresenter(nilaiRepo, mapelRepo),
        super.initial(
          (nilai.npb?..sort((a, b) => a.no.compareTo(b.no)))?.toList() ?? []
      );

  Future<List<MataPelajaran>>? mapelList;
  Future<List<MataPelajaran>> dialogOnFindMapel(String? query) async {
    mapelList ??= _presenter.futureGetMapelList();
    return (await mapelList!).toList();
  }

  void _updateNilaiStatus(RequestStatus status, String actionMessage) {
    if (status == RequestStatus.success) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Berhasil menyimpan perubahan!')));
      refresh();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      dataTableState = RequestState.loading;
      refreshUI();
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(SnackBar(content: Text('Gagal $actionMessage perubahan.')));
  }
  
  @override
  void initListeners() {
    _presenter.updateNilaiStatus = (status) => _updateNilaiStatus(status, 'menyimpan');
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void onSave() {
    nilai.npb = normalList;
    doUpdateNilai(nilai);
  }

  void onExit() async {
    if (dataTableState != RequestState.loaded) {
      showDialog(context: getContext(), builder: (c) => AlertDialog(
        title: const Text('Perhatian!'),
        content: const Text('Jangan keluar saat proses\n'
            'penyimpanan sedang berjalan!'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(c, false),
          ),
        ],
      ));
      return;
    }
    bool exit = false;
    bool isChanged = false;
    if ((nilai.npb?.length ?? 0) != normalList.length) isChanged = true;
    if (!isChanged && normalList.isNotEmpty) {
      for (var i = 0; i < normalList.length; ++i) {
        if (nilai.npb![i] == normalList[i]) continue;
        isChanged = true;
        break;
      }
    }
    if (isChanged) {
      exit = await showDialog<bool>(
        context: getContext(),
        builder: (c) => AlertDialog(
          title: const Text('Konfirmasi Perubahan'),
          content: const Text('Terjadi perubahan di tabel.\n'
              'Perubahan tidak akan tersimpan jika anda keluar sebelum menyimpan.'),
          actions: [
            TextButton(
              child: const Text('KEMBALI KE TABEL'),
              onPressed: () => Navigator.pop(c, false),
            ),
            TextButton(
              child: const Text('KELUAR TANPA MENYIMPAN'),
              onPressed: () => Navigator.pop(c, true),
            ),
          ],
        ),
      ) ?? false;
    }
    else {
      exit = true;
    }

    if (exit) Navigator.pop(getContext());
  }

  @override
  void refresh() => _doGetNPBList();

  void _doGetNPBList() {
    filteredList = normalList;
    selectedMap.addEntries(normalList.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
    dataTableState = RequestState.loaded;
    refreshUI();
  }
  void _doCreateNPB(NPB item) {
    normalList.add(item);
    refresh();
  }
  void _doUpdateNPB(NPB item) {
    final i = normalList.indexWhere((element) => element.no == item.no);
    normalList.replaceRange(i, i+1, [item]);
    refresh();
  }
  void _doDeleteNPB(List<String> ids) {
    normalList.removeWhere((element) => ids.contains(element.no.toString()));
    refresh();
  }
  void doUpdateNilai(Nilai item) => _presenter.doUpdateNilai(item);

  @override
  Widget? createDialog() => ClientNPBCreateDialog(
    lastIndex: (normalList.isEmpty) ? 0 : normalList.last.no+1,
    onSave:  _doCreateNPB,
    controller: this,
  );

  @override
  Widget? updateDialog(NPB? e) => ClientNPBUpdateDialog(
    npb: e!,
    onSave: _doUpdateNPB,
    controller: this,
  );

  @override
  Widget? deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => _doDeleteNPB(selected),
  );

  @override
  String getSelectedKey(NPB e) => e.no.toString();

  @override
  bool searchWhereClause(NPB e) {
    return e.no.toString().contains(currentQuery)
        || e.pelajaran.name.toLowerCase().contains(currentQuery)
        || e.presensi.toString().contains(currentQuery)
        || e.n.toString().contains(currentQuery);
  }
}