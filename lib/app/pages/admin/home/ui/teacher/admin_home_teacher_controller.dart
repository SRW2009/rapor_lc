
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/teacher_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/teacher_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/widgets/custom_datatable_controller.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/teacher/admin_home_teacher_presenter.dart';

class AdminHomeTeacherController extends DataTableController<Teacher> {
  final AdminHomeTeacherPresenter _presenter;
  AdminHomeTeacherController(teacherRepo, divisiRepo)
      : _presenter = AdminHomeTeacherPresenter(teacherRepo, divisiRepo),
        super();

  Future<List<Divisi>>? divisiList;
  Future<List<Divisi>> dialogOnFindDivisi(String? query) async {
    divisiList ??= _presenter.futureGetDivisiList();
    if (query == null || query == '') return divisiList!;

    return (await divisiList!).toList();
  }

  void _getTeacherList(List<Teacher> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getTeacherListState(RequestState state) {
    dataTableState = state;
    refreshUI();
  }

  void _createTeacherStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetTeacherList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal membuat Teacher.')));
  }

  void _updateTeacherStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetTeacherList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah Teacher.')));
  }

  void _deleteTeacherStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetTeacherList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus Teacher.')));
  }

  @override
  void initListeners() {
    _presenter.getTeacherList = _getTeacherList;
    _presenter.getTeacherListState = _getTeacherListState;
    _presenter.createTeacherStatus = _createTeacherStatus;
    _presenter.updateTeacherStatus = _updateTeacherStatus;
    _presenter.deleteTeacherStatus = _deleteTeacherStatus;
  }

  @override
  void refresh() => doGetTeacherList();

  void doGetTeacherList() => _presenter.doGetTeacherList();
  void doCreateTeacher(Teacher item) => _presenter.doCreateTeacher(item);
  void doUpdateTeacher(Teacher item) => _presenter.doUpdateTeacher(item);
  void doDeleteTeacher(List<String> nis) => _presenter.doDeleteTeacher(nis);

  @override
  void onInitState() {
    doGetTeacherList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget? createDialog() => TeacherCreateDialog(
    controller: this,
    onSave: (Teacher item) => doCreateTeacher(item),
  );

  @override
  Widget? updateDialog(Teacher? e) => TeacherUpdateDialog(
    teacher: e!,
    controller: this,
    onSave: (Teacher item) => doUpdateTeacher(item),
  );

  @override
  Widget? deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteTeacher(selected),
  );

  @override
  String getSelectedKey(Teacher e) => e.id.toString();

  @override
  bool searchWhereClause(Teacher e) {
    if (e.id.toString().contains(currentQuery)) return true;
    if (e.name.toLowerCase().contains(currentQuery)) return true;
    if (e.email?.toLowerCase().contains(currentQuery) ?? false) return true;
    if (e.divisi?.name.toLowerCase().contains(currentQuery) ?? false) return true;
    return false;
  }
}