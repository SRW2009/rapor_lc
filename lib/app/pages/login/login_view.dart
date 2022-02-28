
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/pages/Login/Login_controller.dart';
import 'package:rapor_lc/data/repositories/auth_repo_impl.dart';

class LoginPage extends View {
  LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageView createState() => LoginPageView();
}

class LoginPageView extends ViewState<LoginPage, LoginController> {

  LoginPageView()
      : super(LoginController(AuthenticationRepositoryImpl()));

  @override
  Widget get view => Scaffold(key: globalKey, body: body);

  // Scaffold body
  Widget get body => Container();
}