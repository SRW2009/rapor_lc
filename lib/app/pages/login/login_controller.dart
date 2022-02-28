
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/login/login_presenter.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/domain/entities/user.dart';

class LoginController extends Controller {
  RequestState state = RequestState.idle;

  final LoginPresenter _loginPresenter;

  LoginController(authRepo)
      : _loginPresenter = LoginPresenter(authRepo),
        super();

  @override
  void initListeners() {
    _loginPresenter.authOnNext = (isAuth) {
      Navigator.of(getContext()).pushReplacementNamed(Pages.home);
    };
  }

  void doLogin(User user) {
    state = RequestState.loading;
    _loginPresenter.doLogin(user);
  }
}