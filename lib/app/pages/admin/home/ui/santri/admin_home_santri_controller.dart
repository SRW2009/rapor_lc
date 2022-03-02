
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/santri/admin_home_santri_presenter.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class AdminHomeSantriController extends Controller {
  List<Santri>? santriList;
  RequestState santriState = RequestState.idle;

  final AdminHomeSantriPresenter _presenter;
  AdminHomeSantriController(authRepo)
      : _presenter = AdminHomeSantriPresenter(authRepo),
        super();

  void _getSantriList(List<Santri> list) {
    santriList = list;
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
  void doDeleteSantri(String nis) => _presenter.doDeleteSantri(nis);

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