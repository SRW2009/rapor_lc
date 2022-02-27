
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/pages/splash/splash_controller.dart';

class SplashPage extends View {
  SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageView createState() => SplashPageView();
}

class SplashPageView extends ViewState<SplashPage, SplashController>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  SplashPageView()
      : super(SplashController(null));

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    var controller = FlutterCleanArchitecture.getController<SplashController>(context);
    controller.initAnimation(_animationController, _animation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget get view => Scaffold(key: globalKey, body: body);

  // Scaffold body
  Stack get body => Stack(
    children: <Widget>[
      background,
      logo,
    ],
  );

  Positioned get background => Positioned(
    top: 0.0,
    left: 0.0,
    right: 0.0,
    height: MediaQuery.of(context).size.height,
    child: Image.asset(
      Resources.background,
      fit: BoxFit.fill,
    ),
  );

  Positioned get logo => Positioned(
    top: MediaQuery.of(context).size.height / 2 - 50,
    left: 0.0,
    right: 0.0,
    child: Column(
      children: <Widget>[
        FadeTransition(
            opacity: _animation,
            child: Image(
              image: AssetImage(Resources.logo),
              width: 200.0,
            )),
      ],
    ),
  );
}