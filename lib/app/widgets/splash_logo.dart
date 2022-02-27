
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/splash/splash_controller.dart';
import 'package:rapor_lc/app/utils/constants.dart';

class SplashLogo extends StatefulWidget {
  const SplashLogo({Key? key}) : super(key: key);

  @override
  _SplashLogoState createState() => _SplashLogoState();
}

class _SplashLogoState extends State<SplashLogo> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  SplashController? controller;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      final controller = FlutterCleanArchitecture.getController<SplashController>(context);
      controller.initAnimation(_animationController, _animation);
    }

    return FadeTransition(
      opacity: _animation,
      child: const Image(
        image: AssetImage(Resources.logo),
        width: 200.0,
      ),
    );
  }
}
