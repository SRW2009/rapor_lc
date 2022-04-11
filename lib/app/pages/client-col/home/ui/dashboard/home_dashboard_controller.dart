
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client-col/home/home_controller.dart';
import 'package:rapor_lc/app/pages/client-col/home/ui/dashboard/home_dashboard_presenter.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/data/helpers/chart/chart_repo.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class HomeDashboardController extends Controller {
  List<Santri>? santriList;
  RequestState santriState = RequestState.none;

  final HomeDashboardPresenter _presenter;
  final ChartRepository _chartRepository;
  final HomeController homeController;
  HomeDashboardController(santriRepository, this._chartRepository, this.homeController)
      : _presenter = HomeDashboardPresenter(santriRepository),
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

  @override
  void initListeners() {
    _presenter.getSantriListOnNext = _getSantriListOnNext;
    _presenter.getSantriListOnError = _getSantriListOnError;
  }

  void getSantriList() {
    santriState = RequestState.loading;
    refreshUI();
    _presenter.doGetSantriList();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }
}