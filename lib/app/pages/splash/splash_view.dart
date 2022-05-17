
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/splash/splash_controller.dart';
import 'package:rapor_lc/app/utils/constants.dart';
import 'package:rapor_lc/app/widgets/splash_logo.dart';
import 'package:rapor_lc/data/repositories/auth_repo_impl.dart';

class SplashPage extends View {
  SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageView createState() => SplashPageView();
}

class SplashPageView extends ViewState<SplashPage, SplashController> {

  SplashPageView()
      : super(SplashController(AuthenticationRepositoryImpl()));

  @override
  Widget get view => Scaffold(key: globalKey, body: body);

  // Scaffold body
  Stack get body => Stack(
    children: <Widget>[
      background,
      const Center(child: SplashLogo()),
    ],
  );

  Positioned get background => Positioned.fill(
    child: Image.asset(
      Resources.background,
      fit: BoxFit.cover,
    ),
  );
}