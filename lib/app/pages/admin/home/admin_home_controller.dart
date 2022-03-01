
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/home/admin_home_presenter.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/dashboard/admin_home_dashboard_presenter.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/user.dart';

enum AdminHomeState { dashboard, santri, nhb, nk, npb, user }

class AdminHomeController extends Controller {
  AdminHomeState state = AdminHomeState.dashboard;
  User? user;

  final AdminHomePresenter _presenter;
  AdminHomeController(authRepo)
      : _presenter = AdminHomePresenter(authRepo),
        super();

  void _getCurrentUserOnNext(User user) {
    this.user = user;
    refreshUI();
  }

  void _getCurrentUserOnError(e) {
    print(e);
  }

  @override
  void initListeners() {
    _presenter.getCurrentUserOnNext = _getCurrentUserOnNext;
    _presenter.getCurrentUserOnError = _getCurrentUserOnError;
  }

  void _doGetCurrentUser() => _presenter.doGetCurrentUser();

  void changeState(AdminHomeState state) {
    this.state = state;
    refreshUI();
  }

  @override
  void onInitState() {
    _doGetCurrentUser();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }
}