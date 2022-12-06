
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/app/pages/splash/splash_presenter.dart';
import 'package:rapor_lc/common/enum/request_state.dart';

class SplashController extends Controller {
  bool isLoading = false;
  bool isError = false;

  late String page;
  int _authStatus = -1;
  int _retryCount = 0;

  final SplashPresenter _splashPresenter;
  SplashController(authRepo, settingRepo)
      : _splashPresenter = SplashPresenter(authRepo, settingRepo),
        super();

  void _authStatusOnNext(int authStatus) {
    _authStatus = authStatus;
    if (authStatus == 2) {
      page = Pages.admin_home;
      getSettingList();
    } else if (authStatus == 1) {
      page = Pages.home;
      getSettingList();
    } else {
      page = Pages.login;
      Navigator.of(getContext()).pushReplacementNamed(page);
    }
  }

  void _getSettingListState(RequestState state) {
    if (state == RequestState.loaded) {
      isLoading = false;
      Navigator.of(getContext()).pushReplacementNamed(page);
    }
    else if (state == RequestState.error) {
      _retryCount++;
      if (_authStatus > 0 && _retryCount == 2) {
        _splashPresenter.doLogout();
        return;
      }

      isLoading = false;
      isError = true;
      refreshUI();
      Future.delayed(const Duration(seconds: 5), () {
        isLoading = true;
        isError = false;
        refreshUI();
        getSettingList();
      });
    }
  }

  @override
  void initListeners() {
    _splashPresenter.getAuthStatusOnNext = _authStatusOnNext;
    _splashPresenter.getSettingListState = _getSettingListState;
    _splashPresenter.logoutOnComplete = () {
      page = Pages.login;
      Navigator.of(getContext()).pushReplacementNamed(page, arguments: 'Session expired. Please login again.');
    };
  }

  void getAuthStatus() {
    // so the animation can be seen
    Future.delayed(const Duration(seconds: 2), () {
      isLoading = true;
      refreshUI();
      _splashPresenter.getAuthStatus();
    });
  }

  void getSettingList() => _splashPresenter.getSettingList();

  @override
  void onInitState() {
    getAuthStatus();
  }

  @override
  void onDisposed() {
    _splashPresenter.dispose();
    super.onDisposed();
  }
}