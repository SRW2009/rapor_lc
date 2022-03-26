
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/santri_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/santri_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/santri/admin_home_santri_presenter.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/app/widgets/base_datatable_controller.dart';

class AdminHomeSantriController extends DataTableController<Santri> {
  final AdminHomeSantriPresenter _presenter;
  AdminHomeSantriController(authRepo, userRepo)
      : _presenter = AdminHomeSantriPresenter(authRepo, userRepo),
        super();

  Future<List<User>>? teacherList;
  Future<List<User>> dialogOnFindTeacher(String? query) async {
    teacherList ??= _presenter.futureGetTeacherList(1);
    if (query == null || query == '') return teacherList!;

    return (await teacherList!)
        .where((element) => element.email.toLowerCase().contains(query))
        .toList();
  }

  void _getSantriList(List<Santri> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getSantriListState(RequestState state) {
    dataTableState = state;
    refreshUI();
  }

  void _createSantriStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetSantriList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal membuat Santri.')));
  }

  void _updateSantriStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetSantriList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah Santri.')));
  }

  void _deleteSantriStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetSantriList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus Santri.')));
  }

  @override
  void initListeners() {
    _presenter.getSantriList = _getSantriList;
    _presenter.getSantriListState = _getSantriListState;
    _presenter.createSantriStatus = _createSantriStatus;
    _presenter.updateSantriStatus = _updateSantriStatus;
    _presenter.deleteSantriStatus = _deleteSantriStatus;
  }

  @override
  void refresh() => doGetSantriList();

  void doGetSantriList() => _presenter.doGetSantriList();
  void doCreateSantri(Santri santri) => _presenter.doCreateSantri(santri);
  void doUpdateSantri(Santri santri) => _presenter.doUpdateSantri(santri);
  void doDeleteSantri(List<String> nis) => _presenter.doDeleteSantri(nis);

  @override
  void onInitState() {
    doGetSantriList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget createDialog() => SantriCreateDialog(
    controller: this,
    onSave: (Santri santri) => doCreateSantri(santri),
  );

  @override
  Widget updateDialog(Santri e) => SantriUpdateDialog(
    santri: e,
    controller: this,
    onSave: (Santri santri) => doUpdateSantri(santri),
  );

  @override
  Widget deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteSantri(selected),
  );

  @override
  String getSelectedKey(Santri e) => e.nis;

  @override
  bool searchWhereClause(Santri e) {
    if (e.nis.toLowerCase().contains(currentQuery)) return true;
    if (e.nama.toLowerCase().contains(currentQuery)) return true;
    if (e.guru?.email.toLowerCase().contains(currentQuery) ?? false) return true;
    return false;
  }
}