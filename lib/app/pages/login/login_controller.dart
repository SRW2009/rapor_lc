
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/login/login_presenter.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

enum LoginFormState { login, forgotPass }

enum LoginAs { teacher, admin }

class LoginController extends Controller {
  bool isLoading = false;
  LoginFormState formState = LoginFormState.login;
  LoginAs loginAs = LoginAs.teacher;

  late String page;
  int _authStatus = -1;
  int _retryCount = 0;

  final LoginPresenter _loginPresenter;
  LoginController(authRepo, settingRepo)
      : _loginPresenter = LoginPresenter(authRepo, settingRepo),
        super();

  void _authOnNext(int e) {
    _authStatus = e;
    if (e == 2) {
      page = Pages.admin_home;
      getSettingList();
      return;
    }
    if (e == 1) {
      page = Pages.home;
      getSettingList();
      return;
    }

    isLoading = false;
    refreshUI();

    ScaffoldMessenger.of(getContext())
        .showSnackBar(const SnackBar(content: Text('Email atau Password salah.')));
  }

  void _authOnError(e) {
    isLoading = false;
    refreshUI();

    ScaffoldMessenger.of(getContext())
        .showSnackBar(const SnackBar(content: Text('Terjadi Masalah.')));
  }

  void _getSettingListState(RequestState state) {
    if (state == RequestState.loaded) {
      Navigator.of(getContext()).pushReplacementNamed(page);
    }
    else if (state == RequestState.error) {
      _retryCount++;
      if (_authStatus > 0 && _retryCount == 2) {
        ScaffoldMessenger.of(getContext())
            .showSnackBar(const SnackBar(content: Text('Terjadi Masalah. Tolong restart aplikasi.')));

        isLoading = false;
        refreshUI();
        return;
      }

      Future.delayed(const Duration(seconds: 2), () {
        getSettingList();
      });
    }
  }

  @override
  void initListeners() {
    _loginPresenter.authOnNext = _authOnNext;
    _loginPresenter.authOnError = _authOnError;
    _loginPresenter.getSettingListState = _getSettingListState;
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
        final user = Teacher(0, '', email: email, password: password, divisi: Divisi(0,'',false));
        _loginPresenter.doLoginTeacher(user);
      } else {
        final user = Admin(0, '', email: email, password: password);
        _loginPresenter.doLoginAdmin(user);
      }
    }
  }

  void getSettingList() => _loginPresenter.getSettingList();

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