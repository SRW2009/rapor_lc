
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/splash/splash_presenter.dart';
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/pages/splash/splash_view.dart';

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

  void authStatusOnNext(bool isAuth) {
    String page = isAuth ? '/home' : '/login';
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