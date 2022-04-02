
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/login/login_presenter.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/domain/entities/abstract/user.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:flutter/material.dart';

enum LoginFormState { login, forgotPass }

enum LoginAs { teacher, admin }

class LoginController extends Controller {
  bool isLoading = false;
  LoginFormState formState = LoginFormState.login;
  LoginAs loginAs = LoginAs.teacher;

  final LoginPresenter _loginPresenter;
  LoginController(authRepo)
      : _loginPresenter = LoginPresenter(authRepo),
        super();

  void _authOnNext(int e) {
    isLoading = false;
    refreshUI();

    // if teacher logged in as admin
    if (e == 2) {
      Navigator.of(getContext()).pushReplacementNamed(Pages.admin_home);
      return;
    }
    // if teacher logged in as teacher
    if (e == 1) {
      Navigator.of(getContext()).pushReplacementNamed(Pages.home);
      return;
    }

    ScaffoldMessenger.of(getContext())
        .showSnackBar(const SnackBar(content: Text('Email atau Password salah.')));
  }

  void _authOnError(e) {
    isLoading = false;
    refreshUI();

    ScaffoldMessenger.of(getContext())
        .showSnackBar(const SnackBar(content: Text('Terjadi Masalah.')));
  }

  void _forgotPasswordOnNext(bool e) {
    isLoading = false;
    refreshUI();

    if (e) {
      ScaffoldMessenger.of(getContext())
          .showSnackBar(const SnackBar(content: Text('Berhasil reset password!')));
      return;
    }

    ScaffoldMessenger.of(getContext())
        .showSnackBar(const SnackBar(content: Text('Email tidak ditemukan.')));
  }

  void _forgotPasswordOnError(e) {
    isLoading = false;
    refreshUI();

    ScaffoldMessenger.of(getContext())
        .showSnackBar(const SnackBar(content: Text('Terjadi Masalah.')));
  }

  @override
  void initListeners() {
    _loginPresenter.authOnNext = _authOnNext;
    _loginPresenter.authOnError = _authOnError;
    _loginPresenter.forgotPasswordOnNext = _forgotPasswordOnNext;
    _loginPresenter.forgotPasswordOnError = _forgotPasswordOnError;
  }

  void setLoginAs(int i) {
    loginAs = LoginAs.values[i];
    refreshUI();
  }

  void doLogin(GlobalKey<FormState> key, String email, String password) {
    if (key.currentState!.validate()) {
      isLoading = true;
      refreshUI();
      if (loginAs == LoginAs.teacher) {
        final user = Teacher(0, '', email: email, password: password);
        _loginPresenter.doLoginTeacher(user);
      } else {
        final user = Admin(0, '', email: email, password: password);
        _loginPresenter.doLoginAdmin(user);
      }
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