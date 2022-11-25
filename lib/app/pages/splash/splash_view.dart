
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/splash/splash_controller.dart';
import 'package:rapor_lc/app/utils/constants.dart';
import 'package:rapor_lc/app/widgets/splash_logo.dart';
import 'package:rapor_lc/data/repositories/auth_repo_impl.dart';
import 'package:rapor_lc/data/repositories/setting_repo_impl.dart';

class SplashPage extends View {
  SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageView createState() => SplashPageView();
}

class SplashPageView extends ViewState<SplashPage, SplashController> {

  SplashPageView()
      : super(SplashController(AuthenticationRepositoryImpl(), SettingRepositoryImpl()));

  @override
  Widget get view => Scaffold(key: globalKey, body: body);

  // Scaffold body
  Stack get body => Stack(
    children: <Widget>[
      background,
      Positioned.fill(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SplashLogo(),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ControlledWidgetBuilder<SplashController>(
                builder: (context, controller) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: controller.isLoading ? 55 : 0,
                        width: controller.isLoading ? 55 : 0,
                        child: const CircularProgressIndicator(color: Colors.amber, strokeWidth: 8,),
                      ),
                      const SizedBox(height: 8,),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: controller.isError ? 1 : 0,
                        child: Text(
                          'Terjadi masalah saat memuat data.\nMencoba lagi dalam 5 detik...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Positioned get background => Positioned.fill(
    child: Image.asset(
      Resources.background,
      fit: BoxFit.cover,
    ),
  );
}