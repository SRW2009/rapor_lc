
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/admin_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/admin_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/widgets/custom_datatable_controller.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/admin/admin_home_admin_presenter.dart';

class AdminHomeAdminController extends DataTableController<Admin> {
  final AdminHomeAdminPresenter _presenter;
  AdminHomeAdminController(adminRepo)
      : _presenter = AdminHomeAdminPresenter(adminRepo),
        super();

  void _getAdminList(List<Admin> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getAdminListState(RequestState state) {
    dataTableState = state;
    refreshUI();
  }

  void _createAdminStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetAdminList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal membuat Admin.')));
  }

  void _updateAdminStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetAdminList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah Admin.')));
  }

  void _deleteAdminStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetAdminList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus Admin.')));
  }

  @override
  void initListeners() {
    _presenter.getAdminList = _getAdminList;
    _presenter.getAdminListState = _getAdminListState;
    _presenter.createAdminStatus = _createAdminStatus;
    _presenter.updateAdminStatus = _updateAdminStatus;
    _presenter.deleteAdminStatus = _deleteAdminStatus;
  }

  @override
  void refresh() => doGetAdminList();

  void doGetAdminList() => _presenter.doGetAdminList();
  void doCreateAdmin(Admin item) => _presenter.doCreateAdmin(item);
  void doUpdateAdmin(Admin item) => _presenter.doUpdateAdmin(item);
  void doDeleteAdmin(List<String> nis) => _presenter.doDeleteAdmin(nis);

  @override
  void onInitState() {
    doGetAdminList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget? createDialog() => AdminCreateDialog(
    controller: this,
    onSave: (Admin item) => doCreateAdmin(item),
  );

  @override
  Widget? updateDialog(Admin? e) => AdminUpdateDialog(
    admin: e!,
    controller: this,
    onSave: (Admin item) => doUpdateAdmin(item),
  );

  @override
  Widget? deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteAdmin(selected),
  );

  @override
  String getSelectedKey(Admin e) => e.id.toString();

  @override
  bool searchWhereClause(Admin e) {
    if (e.id.toString().contains(currentQuery)) return true;
    if (e.name.toString().contains(currentQuery)) return true;
    if (e.email?.toString().contains(currentQuery) ?? false) return true;
    return false;
  }
}