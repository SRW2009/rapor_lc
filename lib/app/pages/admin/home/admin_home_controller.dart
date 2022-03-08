
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/home/admin_home_presenter.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/divisi/admin_home_divisi_view.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/mapel/admin_home_mapel_view.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/dashboard/admin_home_dashboard_view.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nhb/admin_home_nhb_view.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nk/admin_home_nk_view.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/npb/admin_home_npb_view.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/santri/admin_home_santri_view.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/user/admin_home_user_view.dart';

enum AdminHomeState { dashboard, santri, nhb, nk, npb, user, mapel, divisi }

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

  void _logoutOnComplete() {
    Navigator.of(getContext())
        .pushReplacementNamed(Pages.login);
  }

  @override
  void initListeners() {
    _presenter.getCurrentUserOnNext = _getCurrentUserOnNext;
    _presenter.logoutOnComplete = _logoutOnComplete;
  }

  void _doGetCurrentUser() => _presenter.doGetCurrentUser();
  void _doLogout() => _presenter.doLogout();

  void onLogout() {
    showDialog(
      context: getContext(),
      builder: (context) => AlertDialog(
        title: const Text('Perhatian'),
        content: const Text('Apa anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('TIDAK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _doLogout();
            },
            child: const Text('YA'),
          ),
        ],
      ),
    );
  }

  void changeState(AdminHomeState state) {
    this.state = state;
    refreshUI();
  }

  Widget getUiView(AdminHomeController controller) {
    switch (controller.state) {
      case AdminHomeState.dashboard:
        return AdminHomeDashboardUI();
      case AdminHomeState.santri:
        return AdminHomeSantriUI();
      case AdminHomeState.nhb:
        return AdminHomeNHBUI();
      case AdminHomeState.nk:
        return AdminHomeNKUI();
      case AdminHomeState.npb:
        return AdminHomeNPBUI();
      case AdminHomeState.user:
        return AdminHomeUserUI();
      case AdminHomeState.mapel:
        return AdminHomeMataPelajaranUI();
      case AdminHomeState.divisi:
        return AdminHomeDivisiUI();
      default:
        return Container();
    }
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