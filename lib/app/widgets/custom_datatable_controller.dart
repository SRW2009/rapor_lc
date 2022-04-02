
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';

abstract class DataTableController<Entity> extends Controller {
  List<Entity> normalList = [];
  List<Entity> filteredList = [];
  Map<String, bool> selectedMap = {};
  RequestState dataTableState = RequestState.none;

  void refresh();
  Widget? createDialog();
  Widget? updateDialog(Entity? e);
  Widget? deleteDialog(List<String> selected);
  String getSelectedKey(Entity e);

  bool get createDialogExist => createDialog() != null;
  bool get updateDialogExist => updateDialog(null) != null;
  bool get deleteDialogExist => deleteDialog([]) != null;

  String currentQuery = '';
  bool searchWhereClause(Entity e);
  void tableSearch(String query) {
    if (currentQuery == query) return;
    currentQuery = query;

    filteredList = (query == '')
        ? normalList.cast()
        : normalList.where(searchWhereClause).toList();
    refreshUI();
  }

  void tableOnSelectChanged(String key, bool val) {
    selectedMap[key] = val;
    refreshUI();
  }

  void tableOnAdd() {
    showDialog(
      context: getContext(),
      builder: (context) => createDialog()!,
    );
  }

  void tableOnEdit(Entity e) {
    showDialog(
      context: getContext(),
      builder: (context) => updateDialog(e)!,
    );
  }

  void tableOnDelete() {
    List<String> selected = [];
    for (var i = 0; i < filteredList.length; ++i) {
      String val = getSelectedKey(filteredList[i]);
      var isSelected = selectedMap[val]!;
      if (isSelected) {
        selected.add(val);
      }
    }

    showDialog(
      context: getContext(),
      builder: (context) => deleteDialog(selected)!,
    );
  }
}