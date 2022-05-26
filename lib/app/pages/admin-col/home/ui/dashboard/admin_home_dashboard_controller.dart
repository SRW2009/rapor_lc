
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/dashboard/admin_home_dashboard_presenter.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class AdminHomeDashboardController extends Controller {
  List<Santri> santriList = [];
  List<Santri> filteredSantriList = [];
  Map<int, bool> selectedSantriMap = {};
  RequestState santriState = RequestState.none;

  List<Nilai>? nilaiList;
  RequestState nilaiState = RequestState.none;

  final AdminHomeDashboardPresenter _presenter;
  AdminHomeDashboardController(santriRepository, nilaiRepository)
      : _presenter = AdminHomeDashboardPresenter(santriRepository, nilaiRepository),
        super();

  void _getSantriListOnNext(List<Santri> list) {
    if (list.isEmpty) {
      santriState = RequestState.none;
      refreshUI();
      return;
    }

    santriList = list;
    filteredSantriList = list.cast();
    santriState = RequestState.loaded;
    refreshUI();
  }

  void _getSantriListOnError(e) {
    print(e);
    santriState = RequestState.error;
    refreshUI();
  }

  void _getNilaiListOnNext(List<Nilai> list) {
    if (list.isEmpty) {
      nilaiState = RequestState.none;
      refreshUI();
      return;
    }

    nilaiList = list;
    nilaiState = RequestState.loaded;
    refreshUI();
  }

  void _getNilaiListOnError(e) {
    print(e);
    nilaiState = RequestState.error;
    refreshUI();
  }

  @override
  void initListeners() {
    _presenter.getSantriListOnNext = _getSantriListOnNext;
    _presenter.getSantriListOnError = _getSantriListOnError;
    _presenter.getNilaiListOnNext = _getNilaiListOnNext;
    _presenter.getNilaiListOnError = _getNilaiListOnError;
  }

  void getSantriList() {
    santriState = RequestState.loading;
    refreshUI();
    _presenter.doGetSantriList();
  }
  void getNilaiList() {
    nilaiState = RequestState.loading;
    refreshUI();
    _presenter.doGetNilaiList();
  }

  @override
  void onInitState() {
    getSantriList();
    getNilaiList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  String currentQuery = '';
  void tableOnSearch(String q) {
    var query = q.toLowerCase();
    if (currentQuery == query) return;
    currentQuery = query;

    filteredSantriList = (query == '')
        ? santriList.cast()
        : santriList.where((e) =>
            e.id.toString().contains(query)
            || (e.nis?.contains(query) ?? false)
            || e.name.toLowerCase().contains(query)
    ).toList();
    refreshUI();
  }

  void tableOnSelectChanged(int id, bool val) {
    selectedSantriMap[id] = val;
    refreshUI();
  }

  int tableRadioFilterValue = 0;
  void tableRadioOnChanged(int? value) {
    if (value == null) return;
    currentQuery = '';
    tableRadioFilterValue = value;
    if (value == 0) {
      filteredSantriList = santriList.cast();
    }
    else {
      filteredSantriList = getAllSelectedSantri();
    }
    refreshUI();
  }

  List<Santri> getAllSelectedSantri() => santriList.where((e) => selectedSantriMap[e.id] ?? false).toList();
}