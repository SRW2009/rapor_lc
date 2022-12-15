
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client-col/home/ui/record/home_record_presenter.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class HomeRecordController extends Controller {
  List<Relation> _initialSantriList;
  List<Relation> shownSantriList;
  RequestState santriListState;

  final HomeRecordPresenter _presenter;
  HomeRecordController(relationRepo)
      : _presenter = HomeRecordPresenter(relationRepo),
        _initialSantriList = [], shownSantriList = [],
        santriListState = RequestState.none,
        super();

  void _getRelationList(List<Relation> list) {
    _initialSantriList = list;
    shownSantriList = list;
  }

  void _getRelationListState(RequestState state) {
    santriListState = state;
    refreshUI();
  }

  @override
  void initListeners() {
    _presenter.getRelationList = _getRelationList;
    _presenter.getRelationListState = _getRelationListState;
  }

  void doGetMySantriList() => _presenter.doGetRelationList();

  void onTapItem(Santri santri) {
    Navigator.of(getContext())
        .pushNamed(Pages.manage_nilai, arguments: santri);
  }

  void onSearch(String query) {
    if (query.isEmpty) {
      shownSantriList = _initialSantriList;
    }
    else {
      shownSantriList = _initialSantriList
          .where((item) => _searchWhereClause(item, query)).toList();
    }
    refreshUI();
  }

  bool _searchWhereClause(Relation item, String query) {
    return (item.name?.toLowerCase().contains(query) ?? false)
        || item.santri.name.toLowerCase().contains(query)
        || (item.santri.nis?.contains(query) ?? false);
  }

  @override
  void onInitState() {
    doGetMySantriList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }
}