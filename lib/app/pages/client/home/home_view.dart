
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client/home/home_controller.dart';
import 'package:rapor_lc/app/utils/constants.dart';
import 'package:rapor_lc/data/repositories/auth_repo_impl.dart';
import 'package:rapor_lc/data/test-repositories/auth_repo_impl.dart';

class HomePage extends View {
  HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageView();
}

class HomePageView extends ViewState<HomePage, HomeController> {
  HomePageView()
      : super(HomeController(AuthenticationRepositoryImplTest()));

  @override
  Widget get view => Scaffold(
    key: globalKey,
    appBar: AppBar(
      title: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) => Text(controller.getTitle())
      ),
    ),
    drawer: Drawer(
      child: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) => Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Resources.background),
                  fit: BoxFit.cover,
                ),
              ),
              accountName: Text(controller.user?.email ?? ''),
              accountEmail: Text(controller.user?.getStatusName ?? ''),
            ),
            _drawerItem('Dashboard', HomeState.dashboard, controller),
            _drawerItem('Daftar Santri', HomeState.santri, controller),
            _drawerItem('Input Nilai', HomeState.record, controller),
            _drawerItemLogout(controller),
          ],
        ),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) => controller.getUiView(controller),
      ),
    ),
  );

  ListTile _drawerItem(String title,
      HomeState state, HomeController controller) => ListTile(
    onTap: () {
      Navigator.pop(context);
      controller.changeState(state);
    },
    selected: controller.state == state,
    title: Text(title),
  );

  ListTile _drawerItemLogout(HomeController controller) => ListTile(
    onTap: () {
      Navigator.pop(context);
      controller.onLogout();
    },
    title: const Text('Logout'),
  );
}