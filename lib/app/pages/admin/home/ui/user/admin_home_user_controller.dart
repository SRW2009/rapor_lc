
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/base_datatable_controller.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/user/admin_home_user_presenter.dart';

class AdminHomeUserController extends DataTableController<User> {
  RequestState dataState = RequestState.none;

  final AdminHomeUserPresenter _presenter;
  AdminHomeUserController(userRepo)
      : _presenter = AdminHomeUserPresenter(userRepo),
        super();

  void _getUserList(List<User> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getUserListState(RequestState state) {
    dataState = state;
    refreshUI();
  }

  void _createUserStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetUserList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal membuat User.')));
  }

  void _updateUserStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetUserList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah User.')));
  }

  void _deleteUserStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetUserList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus User.')));
  }

  @override
  void initListeners() {
    _presenter.getUserList = _getUserList;
    _presenter.getUserListState = _getUserListState;
    _presenter.createUserStatus = _createUserStatus;
    _presenter.updateUserStatus = _updateUserStatus;
    _presenter.deleteUserStatus = _deleteUserStatus;
  }

  void doGetUserList() => _presenter.doGetUserList();
  void doCreateUser(User item) => _presenter.doCreateUser(item);
  void doUpdateUser(User item) => _presenter.doUpdateUser(item);
  void doDeleteUser(List<String> nis) => _presenter.doDeleteUser(nis);

  @override
  void onInitState() {
    doGetUserList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget createDialog() => Container();/*UserCreateDialog(
    controller: this,
    onSave: (User item) => doCreateUser(item),
  );*/

  @override
  Widget updateDialog(User e) => Container();/*UserUpdateDialog(
    nk: e,
    controller: this,
    onSave: (User item) => doUpdateUser(item),
  );*/

  @override
  Widget deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteUser(selected),
  );

  @override
  String getSelectedKey(User e) => e.email;

  @override
  bool searchWhereClause(User e) {
    if (e.email.toString().contains(currentQuery)) return true;
    if (e.getStatusName.toLowerCase().contains(currentQuery)) return true;
    return false;
  }
}