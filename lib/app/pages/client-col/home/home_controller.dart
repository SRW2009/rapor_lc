
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/domain/entities/abstract/user.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

import 'ui/record/home_record_view.dart';
import 'ui/account/home_account_view.dart';
import 'home_presenter.dart';

class HomeController extends Controller {
  int navIndex = 0;
  Teacher? user;

  final HomePresenter _presenter;
  HomeController(authRepo)
      : _presenter = HomePresenter(authRepo),
        super();

  void _getCurrentUserOnNext(User? user) {
    this.user = user as Teacher;
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

  void onTapNav(int value) {
    navIndex = value;
    refreshUI();
  }

  String get getTitle {
    switch (navIndex) {
      case 0:
        return 'Pilih Murid';
      case 1:
        return 'Akun';
      default:
        return '';
    }
  }

  Widget getUiView() {
    switch (navIndex) {
      case 0:
        return HomeRecordUI();
      case 1:
        return HomeAccountUI(homeController: this);
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