
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/dialogs/admin/santri_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/santri_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/santri/admin_home_santri_presenter.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/user.dart';

class AdminHomeSantriController extends Controller {
  List<Santri> santriList = [];
  RequestState santriState = RequestState.none;
  List<bool> santriSelected = [];

  Future<List<User>>? teacherList;

  final AdminHomeSantriPresenter _presenter;
  AdminHomeSantriController(authRepo, userRepo)
      : _presenter = AdminHomeSantriPresenter(authRepo, userRepo),
        super();

  int sortedColumnIndex = 0;
  bool sortedIsAsc = true;
  void onSort(int columnI, bool _) {
    if (columnI == sortedColumnIndex) {
      sortedIsAsc = !sortedIsAsc;
      sa
      refreshUI();
      return;
    }

    sortedIsAsc = true;

  }

  void tableOnSelectChanged(int i, bool val) {
    santriSelected[i] = val;
    refreshUI();
  }

  void tableOnAdd() {
    showDialog(
      context: getContext(),
      builder: (context) => SantriCreateDialog(
        controller: this,
        onSave: (Santri santri) => doCreateSantri(santri),
      ),
    );
  }

  void tableOnEdit(Santri santri) {
    showDialog(
      context: getContext(),
      builder: (context) =>
        SantriUpdateDialog(
          santri: santri,
          controller: this,
          onSave: (Santri santri) => doUpdateSantri(santri),
        ),
    );
  }

  void tableOnDelete() {
    List<String> selectedSantri = [];
    for (var i = 0; i < santriSelected.length; ++i) {
      var isSelected = santriSelected[i];
      if (isSelected) {
        selectedSantri.add(santriList[i].nis);
      }
    }

    showDialog(
      context: getContext(),
      builder: (context) => DeleteDialog(
        showDeleted: () => selectedSantri,
        onSave: () => doDeleteSantri(selectedSantri),
      ),
    );
  }

  Future<List<User>> dialogOnFind(String? query) async {
    teacherList ??= _presenter.futureGetTeacherList(1);
    if (query == null || query == '') return teacherList!;

    return (await teacherList!)
        .where((element) => element.email.toLowerCase().contains(query))
        .toList();
  }

  void _getSantriList(List<Santri> list) {
    santriList = list;
    santriSelected = List<bool>.generate(list.length, (index) => false);
  }

  void _getSantriListState(RequestState state) {
    santriState = state;
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
}