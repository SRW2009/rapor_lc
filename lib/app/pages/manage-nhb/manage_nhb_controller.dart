
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/common/nhb_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/common/nhb_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/manage-nhb/manage_nhb_presenter.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/app/widgets/custom_datatable_controller.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class ManageNHBController extends DataTableController<NHB> {
  final Nilai _nilai;
  bool tableHasChanged = false;

  final ManageNHBPresenter _presenter;
  ManageNHBController(nilaiRepo, mapelRepo, this._nilai)
      : _presenter = ManageNHBPresenter(nilaiRepo, mapelRepo),
        super.initial(
          (_nilai.nhb..sort((a, b) => a.no.compareTo(b.no))).toList()
      );

  Future<List<MataPelajaran>>? mapelList;
  Future<List<MataPelajaran>> dialogOnFindMapel(String? query) async {
    mapelList ??= _presenter.futureGetMapelList();
    return await mapelList!;
  }

  void _updateNilaiStatus(RequestStatus status, String actionMessage) {
    if (status == RequestStatus.success) {
      tableHasChanged = false;
      ScaffoldMessenger.of(getContext())
          .showSnackBar(SnackBar(content: Text('Berhasil $actionMessage perubahan!')));
      refresh();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext())
          .showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      dataTableState = RequestState.loading;
      refreshUI();
      return;
    }

    ScaffoldMessenger.of(getContext())
        .showSnackBar(SnackBar(content: Text('Gagal $actionMessage perubahan.')));
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
    _nilai.nhb = normalList.toList();
    _doUpdateNilai(_nilai);
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
    if (tableHasChanged) {
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
  void refresh() => _doGetNHBList();

  void _doGetNHBList() {
    filteredList = normalList;
    selectedMap.addEntries(normalList.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
    dataTableState = RequestState.loaded;
    refreshUI();
  }
  void _doCreateNHB(NHB item) {
    normalList.add(item);
    tableHasChanged = true;
    refresh();
  }
  void _doUpdateNHB(NHB item) {
    final i = normalList.indexWhere((element) => element.no == item.no);
    normalList.replaceRange(i, i+1, [item]);
    tableHasChanged = true;
    refresh();
  }
  void _doDeleteNHB(List<String> nos) {
    normalList.removeWhere((element) => nos.contains(element.no.toString()));
    tableHasChanged = true;
    refresh();
  }
  void _doUpdateNilai(Nilai item) => _presenter.doUpdateNilai(item);

  @override
  Widget? createDialog() => NHBCreateDialog(
    lastIndex: (normalList.isEmpty) ? 0 : normalList.last.no+1,
    controller: this,
    onSave: (NHB item) => _doCreateNHB(item),
  );

  @override
  Widget? updateDialog(NHB? e) => NHBUpdateDialog(
    nhb: e!,
    controller: this,
    onSave: (NHB item) => _doUpdateNHB(item),
  );

  @override
  Widget? deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => _doDeleteNHB(selected),
  );

  @override
  String getSelectedKey(NHB e) => e.no.toString();

  @override
  bool searchWhereClause(NHB e) => e.no.toString().contains(currentQuery)
      || e.pelajaran.name.toLowerCase().contains(currentQuery)
      || e.nilai_harian.toString().contains(currentQuery)
      || e.nilai_bulanan.toString().contains(currentQuery)
      || e.nilai_projek.toString().contains(currentQuery)
      || e.nilai_akhir.toString().contains(currentQuery)
      || e.akumulasi.toString().contains(currentQuery)
      || e.predikat.toLowerCase().contains(currentQuery);
}