
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/pages/login/login_controller.dart';
import 'package:rapor_lc/data/repositories/auth_repo_impl.dart';

class LoginPage extends View {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageView();
}

class LoginPageView extends ViewState<LoginPage, LoginController> {

  LoginPageView()
      : super(LoginController(AuthenticationRepositoryImpl()));

  @override
  Widget get view => Scaffold(
    key: globalKey,
    body: Container(),
  );
}