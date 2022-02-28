
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/login/login_presenter.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:flutter/material.dart';

enum LoginFormState { login, forgotPass }

class LoginController extends Controller {
  bool isLoading = false;
  LoginFormState formState = LoginFormState.login;

  final LoginPresenter _loginPresenter;

  LoginController(authRepo)
      : _loginPresenter = LoginPresenter(authRepo),
        super();

  void authOnNext(bool e) {
    isLoading = false;
    refreshUI();

    if (e) {
      Navigator.of(getContext()).pushReplacementNamed(Pages.home);
    } else {
      ScaffoldMessenger.of(getContext())
          .showSnackBar(const SnackBar(content: Text('Email atau Password salah.')));
    }
  }

  void authOnError(e) {
    isLoading = false;
    refreshUI();

    ScaffoldMessenger.of(getContext())
        .showSnackBar(const SnackBar(content: Text('Terjadi Masalah.')));
  }

  void forgotPasswordOnNext(bool e) {
    isLoading = false;
    refreshUI();

    if (e) {
      ScaffoldMessenger.of(getContext())
          .showSnackBar(const SnackBar(content: Text('Berhasil reset password!')));
    } else {
      ScaffoldMessenger.of(getContext())
          .showSnackBar(const SnackBar(content: Text('Email tidak ditemukan.')));
    }
  }

  void forgotPasswordOnError(e) {
    isLoading = false;
    refreshUI();

    ScaffoldMessenger.of(getContext())
        .showSnackBar(const SnackBar(content: Text('Terjadi Masalah.')));
  }

  @override
  void initListeners() {
    _loginPresenter.authOnNext = authOnNext;
    _loginPresenter.authOnError = authOnError;
    _loginPresenter.forgotPasswordOnNext = forgotPasswordOnNext;
    _loginPresenter.forgotPasswordOnError = forgotPasswordOnError;
  }

  void doLogin(GlobalKey<FormState> key, User user) {
    if (key.currentState!.validate()) {
      isLoading = true;
      refreshUI();
      _loginPresenter.doLogin(user);
    }
  }

  void doForgotPassword(GlobalKey<FormState> key, String email) {
    if (key.currentState!.validate()) {
      isLoading = true;
      refreshUI();
      _loginPresenter.doForgotPassword(email);
    }
  }

  void toLogin() {
    formState = LoginFormState.login;
    refreshUI();
  }

  void toForgotPassword() {
    formState = LoginFormState.forgotPass;
    refreshUI();
  }

  @override
  void onDisposed() {
    _loginPresenter.dispose();
    super.onDisposed();
  }
}