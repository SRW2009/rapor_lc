
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client-col/home/home_controller.dart';
import 'package:rapor_lc/data/repositories/auth_repo_impl.dart';

class HomePage extends View {
  HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageView();
}

class HomePageView extends ViewState<HomePage, HomeController> {
  HomePageView()
      : super(HomeController(AuthenticationRepositoryImpl()));

  @override
  Widget get view => Container(
    key: globalKey,
    child: ControlledWidgetBuilder<HomeController>(
      builder: (context, controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(controller.getTitle),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: controller.onTapNav,
            currentIndex: controller.navIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.edit),
                label: 'Input Nilai',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Akun',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.getUiView(),
          ),
        );
      }
    ),
  );
}