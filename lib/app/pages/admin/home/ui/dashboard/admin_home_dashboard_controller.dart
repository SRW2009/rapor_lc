
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/dashboard/admin_home_dashboard_presenter.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/data/helpers/chart/chart_repo.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class AdminHomeDashboardController extends Controller {
  List<Santri>? santriList;
  RequestState santriState = RequestState.none;

  List<Nilai>? nilaiList;
  RequestState nilaiState = RequestState.none;

  final AdminHomeDashboardPresenter _presenter;
  final ChartRepository _chartRepository;
  AdminHomeDashboardController(santriRepository, nilaiRepository, this._chartRepository)
      : _presenter = AdminHomeDashboardPresenter(santriRepository, nilaiRepository),
        super();

  void _getSantriListOnNext(List<Santri> list) {
    if (list.isEmpty) {
      santriState = RequestState.none;
      refreshUI();
      return;
    }

    santriList = list;
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
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }
}