
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/dashboard/admin_home_dashboard_presenter.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/data/helpers/chart/chart_repo.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class AdminHomeDashboardController extends Controller {
  List<Santri>? santriList;
  RequestState santriState = RequestState.none;

  List<NHB>? nhbList;
  RequestState nhbState = RequestState.none;

  List<NK>? nkList;
  RequestState nkState = RequestState.none;

  List<NPB>? npbList;
  RequestState npbState = RequestState.none;

  final AdminHomeDashboardPresenter _presenter;
  final ChartRepository _chartRepository;
  AdminHomeDashboardController(santriRepository, nhbRepository, nkRepository, npbRepository, this._chartRepository)
      : _presenter = AdminHomeDashboardPresenter(santriRepository, nhbRepository, nkRepository, npbRepository),
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

  void _getNHBListOnNext(List<NHB> list) {
    if (list.isEmpty) {
      nhbState = RequestState.none;
      refreshUI();
      return;
    }

    nhbList = list;
    nhbState = RequestState.loaded;
    refreshUI();
  }

  void _getNHBListOnError(e) {
    print(e);
    nhbState = RequestState.error;
    refreshUI();
  }

  void _getNKListOnNext(List<NK> list) {
    if (list.isEmpty) {
      nkState = RequestState.none;
      refreshUI();
      return;
    }

    nkList = list;
    nkState = RequestState.loaded;
    refreshUI();
  }

  void _getNKListOnError(e) {
    print(e);
    nkState = RequestState.error;
    refreshUI();
  }

  void _getNPBListOnNext(List<NPB> list) {
    if (list.isEmpty) {
      npbState = RequestState.none;
      refreshUI();
      return;
    }

    npbList = list;
    npbState = RequestState.loaded;
    refreshUI();
  }

  void _getNPBListOnError(e) {
    print(e);
    npbState = RequestState.error;
    refreshUI();
  }

  @override
  void initListeners() {
    _presenter.getSantriListOnNext = _getSantriListOnNext;
    _presenter.getSantriListOnError = _getSantriListOnError;
    _presenter.getNHBListOnNext = _getNHBListOnNext;
    _presenter.getNHBListOnError = _getNHBListOnError;
    _presenter.getNKListOnNext = _getNKListOnNext;
    _presenter.getNKListOnError = _getNKListOnError;
    _presenter.getNPBListOnNext = _getNPBListOnNext;
    _presenter.getNPBListOnError = _getNPBListOnError;
  }

  void getSantriList() {
    santriState = RequestState.loading;
    refreshUI();
    _presenter.doGetSantriList();
  }
  void getNHBList() {
    nhbState = RequestState.loading;
    refreshUI();
    _presenter.doGetNHBList();
  }
  void getNKList() {
    nkState = RequestState.loading;
    refreshUI();
    _presenter.doGetNKList();
  }
  void getNPBList() {
    npbState = RequestState.loading;
    refreshUI();
    _presenter.doGetNPBList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }
}