
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client-col/home/ui/record/home_record_presenter.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class HomeRecordController extends Controller {
  List<Santri> _initialSantriList;
  List<Santri> shownSantriList;
  RequestState santriListState;
  List<Nilai> nilaiList;
  RequestState nilaiListState;

  final HomeRecordPresenter _presenter;
  HomeRecordController(santriRepo, nilaiRepo)
      : _presenter = HomeRecordPresenter(santriRepo, nilaiRepo),
        _initialSantriList = [], shownSantriList = [], nilaiList = [],
        santriListState = RequestState.none,
        nilaiListState = RequestState.none,
        super();

  void _getSantriList(List<Santri> list) {
    _initialSantriList = list;
    shownSantriList = list;
  }

  void _getSantriListState(RequestState state) {
    santriListState = state;
    refreshUI();
  }

  void _getNilaiList(List<Nilai> list) {
    nilaiList = list;
  }

  void _getNilaiListState(RequestState state) {
    nilaiListState = state;
    refreshUI();
  }

  @override
  void initListeners() {
    _presenter.getSantriList = _getSantriList;
    _presenter.getSantriListState = _getSantriListState;
    _presenter.getNilaiList = _getNilaiList;
    _presenter.getNilaiListState = _getNilaiListState;
  }

  void doGetSantriList() => _presenter.doGetSantriList();
  void doGetNilaiList() => _presenter.doGetNilaiList();

  void onTapItem(Santri item) async {
    if (nilaiListState == RequestState.loaded || nilaiListState == RequestState.none) {
      final santriNilaiList = nilaiList.where((element) => element.santri == item).toList();
      santriNilaiList.sort((a, b) => a.timeline.compareTo(b.timeline));
      final result = ((await Navigator.of(getContext())
          .pushNamed(Pages.manage_nilai, arguments: [item, santriNilaiList])) as List<Nilai>?)?.toList();
      if (result != null) {
        nilaiList.removeWhere((element) => element.santri == item);
        nilaiList.addAll(result);
      }
      return;
    }
    if (nilaiListState == RequestState.error) {
      ScaffoldMessenger.of(getContext())
          .showSnackBar(const SnackBar(content: Text(
          'Terjadi masalah saat memuat nilai. '
          'Mencoba untuk memuat ulang...',
      )));
      doGetNilaiList();
      return;
    }
    ScaffoldMessenger.of(getContext())
        .showSnackBar(const SnackBar(content: Text('Masih memuat...')));
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

  bool _searchWhereClause(Santri item, String query) {
    return item.name.toLowerCase().contains(query)
        || (item.nis?.contains(query) ?? false);
  }

  @override
  void onInitState() {
    doGetSantriList();
    doGetNilaiList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }
}