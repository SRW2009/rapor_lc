
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/admin/relation_create_dialog.dart';
import 'package:rapor_lc/app/dialogs/admin/relation_update_dialog.dart';
import 'package:rapor_lc/app/dialogs/dialogs.dart';
import 'package:rapor_lc/app/widgets/custom_datatable_controller.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/relation/admin_home_relation_presenter.dart';

class AdminHomeRelationController extends DataTableController<Relation> {
  final AdminHomeRelationPresenter _presenter;
  AdminHomeRelationController(relationRepo, divisiRepo, santriRepo)
      : _presenter = AdminHomeRelationPresenter(relationRepo, divisiRepo, santriRepo),
        super();

  Future<List<Teacher>>? teacherList;
  Future<List<Teacher>> dialogOnFindTeacher(String? query) async {
    teacherList ??= _presenter.futureGetTeacherList();
    if (query == null || query == '') return teacherList!;

    return (await teacherList!).toList();
  }

  Future<List<Santri>>? santriList;
  Future<List<Santri>> dialogOnFindSantri(String? query) async {
    santriList ??= _presenter.futureGetSantriList();
    if (query == null || query == '') return santriList!;

    return (await santriList!).toList();
  }

  void _getRelationList(List<Relation> list) {
    normalList = list;
    filteredList = list;
    selectedMap.addEntries(list.map<MapEntry<String, bool>>
      ((e) => MapEntry(getSelectedKey(e), false)));
  }

  void _getRelationListState(RequestState state) {
    dataTableState = state;
    refreshUI();
  }

  void _createRelationStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetRelationList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal membuat Relation.')));
  }

  void _updateRelationStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetRelationList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal mengubah Relation.')));
  }

  void _deleteRelationStatus(RequestStatus status) {
    if (status == RequestStatus.success) {
      doGetRelationList();
      return;
    }
    if (status == RequestStatus.loading) {
      ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Mohon tunggu...')));
      return;
    }

    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(content: Text('Gagal menghapus Relation.')));
  }

  @override
  void initListeners() {
    _presenter.getRelationList = _getRelationList;
    _presenter.getRelationListState = _getRelationListState;
    _presenter.createRelationStatus = _createRelationStatus;
    _presenter.updateRelationStatus = _updateRelationStatus;
    _presenter.deleteRelationStatus = _deleteRelationStatus;
  }

  @override
  void refresh() => doGetRelationList();

  void doGetRelationList() => _presenter.doGetRelationList();
  void doCreateRelation(Relation item) => _presenter.doCreateRelation(item);
  void doUpdateRelation(Relation item) => _presenter.doUpdateRelation(item);
  void doDeleteRelation(List<String> nis) => _presenter.doDeleteRelation(nis);

  @override
  void onInitState() {
    doGetRelationList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  Widget? createDialog() => RelationCreateDialog(
    controller: this,
    onSave: (Relation item) => doCreateRelation(item),
  );

  @override
  Widget? updateDialog(Relation? e) => RelationUpdateDialog(
    relation: e!,
    controller: this,
    onSave: (Relation item) => doUpdateRelation(item),
  );

  @override
  Widget? deleteDialog(List<String> selected) => DeleteDialog(
    showDeleted: () => selected,
    onSave: () => doDeleteRelation(selected),
  );

  @override
  String getSelectedKey(Relation e) => e.id.toString();

  @override
  bool searchWhereClause(Relation e) {
    if (e.id.toString().contains(currentQuery)) return true;
    if (e.santri.name.toLowerCase().contains(currentQuery)) return true;
    if (e.teacher.name.toLowerCase().contains(currentQuery)) return true;
    return false;
  }
}