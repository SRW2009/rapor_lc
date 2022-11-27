
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/common/nk_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/common/nk_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/manage-nk/manage_nk_presenter.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/app/subclasses/custom_datatable_controller.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class ManageNKController extends DataTableController<NK> {
  late final Nilai _nilai;
  bool tableHasChanged = false;

  final ManageNKPresenter _presenter;
  ManageNKController(nilaiRepo, mapelRepo, this._nilai)
      : _presenter = ManageNKPresenter(nilaiRepo, mapelRepo),
        super.initial(
          (_nilai.nk..sort((a, b) => a.no.compareTo(b.no))).toList()
      );

  Future<List<MataPelajaran>>? varList;
  Future<List<MataPelajaran>> dialogOnFindNKVariables(String? query) async {
    varList ??= _presenter.futureGetNKVariables();
    return await varList!;
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
    _nilai.nk = normalList.toList();
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
  void refresh() => _doGetNKList();

  void _doGetNKList() {
    filteredList = normalList;
    selectedMap.addEntries(normalList.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
    dataTableState = RequestState.loaded;
    refreshUI();
  }
  void _doCreateNK(NK item) {
    normalList.add(item);
    tableHasChanged = true;
    refresh();
  }
  void _doUpdateNK(NK item) {
    final i = normalList.indexWhere((element) => element.no == item.no);
    normalList.replaceRange(i, i+1, [item]);
    tableHasChanged = true;
    refresh();
  }
  void _doDeleteNK(List<String> nos) {
    normalList.removeWhere((element) => nos.contains(element.no.toString()));
    tableHasChanged = true;
    refresh();
  }
  void _doUpdateNilai(Nilai item) => _presenter.doUpdateNilai(item);

  @override
  Widget? createDialog() => NKCreateDialog(
    lastIndex: (normalList.isEmpty) ? 0 : normalList.last.no+1,
    onFindVariables: dialogOnFindNKVariables,
    onSave: (NK item) => _doCreateNK(item),
  );

  @override
  Widget? updateDialog(NK? e) => NKUpdateDialog(
    nk: e!,
    onFindVariables: dialogOnFindNKVariables,
    onSave: (NK item) => _doUpdateNK(item),
  );

  @override
  Widget? deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => _doDeleteNK(selected),
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