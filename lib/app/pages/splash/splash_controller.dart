
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/app/pages/splash/splash_presenter.dart';

class SplashController extends Controller {
  bool isLoading = false;
  final SplashPresenter _splashPresenter;

  SplashController(authRepo)
      : _splashPresenter = SplashPresenter(authRepo),
        super();

  @override
  void onInitState() {
    getAuthStatus();
  }

  void authStatusOnNext(int authStatus) {
    String page;
    if (authStatus == 2) {
      page = Pages.admin_home;
    } else if (authStatus == 1) {
      page = Pages.home;
    } else {
      page = Pages.login;
    }

    Navigator.of(getContext()).pushReplacementNamed(page);
  }

  void getAuthStatus() async {
    isLoading = true;
    // so the animation can be seen
    Future.delayed(const Duration(seconds: 3), _splashPresenter.getAuthStatus);
  }

  @override
  void initListeners() {
    _splashPresenter.getAuthStatusOnNext = authStatusOnNext;
    _splashPresenter.getAuthStatusOnComplete = () => isLoading = false;
  }

  @override
  void onDisposed() {
    _splashPresenter.dispose();
    super.onDisposed();
  }
}