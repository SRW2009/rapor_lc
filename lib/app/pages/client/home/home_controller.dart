
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client/home/home_presenter.dart';
import 'package:rapor_lc/app/pages/client/home/ui/dashboard/home_dashboard_view.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

enum HomeState { dashboard, santri, record }

class HomeController extends Controller {
  HomeState state = HomeState.dashboard;
  Teacher? user;

  final HomePresenter _presenter;
  HomeController(authRepo)
      : _presenter = HomePresenter(authRepo),
        super();

  void _getCurrentUserOnNext(Teacher? user) {
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

  String getTitle() {
    switch (state) {
      case HomeState.dashboard:
        return 'Beranda';
      case HomeState.santri:
        return 'Daftar Murid';
      case HomeState.record:
        return 'Input Nilai';
      default:
        return '';
    }
  }

  void changeState(HomeState state) {
    this.state = state;
    refreshUI();
  }

  Widget getUiView(HomeController controller) {
    switch (controller.state) {
      case HomeState.dashboard:
        return HomeDashboardUI();
      case HomeState.santri:
        //return;
      case HomeState.record:
        //return;
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