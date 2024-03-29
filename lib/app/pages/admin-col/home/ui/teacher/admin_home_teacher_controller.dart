
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/teacher_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/teacher_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/subclasses/custom_datatable_controller.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/teacher/admin_home_teacher_presenter.dart';

class AdminHomeTeacherController extends DataTableController<Teacher> {
  final AdminHomeTeacherPresenter _presenter;
  AdminHomeTeacherController(teacherRepo, divisiRepo)
      : _presenter = AdminHomeTeacherPresenter(teacherRepo, divisiRepo),
        super();

  List<Divisi>? divisiList;
  List<Divisi>? divisiBlockList;
  Future<List<Divisi>> dialogOnFindDivisi(String? query, bool isBlock) async {
    final list = await _presenter.futureGetDivisiList();
    divisiList ??= list.where((element) => !element.isBlock).toList();
    divisiBlockList ??= list.where((element) => element.isBlock).toList();
    return (isBlock) ? divisiBlockList! : divisiList!;
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
    onFindDivisi: dialogOnFindDivisi,
    onSave: (Teacher item) => doCreateTeacher(item),
  );

  @override
  Widget? updateDialog(Teacher? e) => TeacherUpdateDialog(
    teacher: e!,
    onFindDivisi: dialogOnFindDivisi,
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
  bool searchWhereClause(Teacher e) =>
      (e.id.toString().contains(currentQuery))
      || (e.name.toLowerCase().contains(currentQuery))
      || (e.email?.toLowerCase().contains(currentQuery) ?? false)
      || (e.divisi.name.toLowerCase().contains(currentQuery))
      || (e.divisiBlock?.name.toLowerCase().contains(currentQuery) ?? false);
}