
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/admin_home_controller.dart';
import 'package:rapor_lc/app/utils/constants.dart';
import 'package:rapor_lc/data/repositories/auth_repo_impl.dart';

class AdminHomePage extends View {
  AdminHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomePageView();
}

class AdminHomePageView extends ViewState<AdminHomePage, AdminHomeController> {
  AdminHomePageView()
      : super(AdminHomeController(AuthenticationRepositoryImpl()));

  @override
  Widget get view => Scaffold(
    key: globalKey,
    appBar: AppBar(
      title: const Text('Admin'),
    ),
    drawer: Drawer(
      child: ControlledWidgetBuilder<AdminHomeController>(
        builder: (context, controller) => Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Resources.background),
                  fit: BoxFit.cover,
                ),
              ),
              accountName: Text(controller.user?.name ?? ''),
              accountEmail: Text(controller.user?.email ?? ''),
            ),
            _drawerItem('Dashboard', AdminHomeState.dashboard, controller),
            _drawerItem('Santri', AdminHomeState.santri, controller),
            _drawerItem('Guru', AdminHomeState.teacher, controller),
            _drawerItem('Admin', AdminHomeState.admin, controller),
            _drawerItem('Mata Pelajaran', AdminHomeState.mapel, controller),
            _drawerItem('Divisi', AdminHomeState.divisi, controller),
            _drawerItem('Nilai', AdminHomeState.nilai, controller),
            _drawerItem('Relasi', AdminHomeState.relasi, controller),
            _drawerItemLogout(controller),
          ],
        ),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ControlledWidgetBuilder<AdminHomeController>(
        builder: (context, controller) => controller.getUiView(controller),
      ),
    ),
  );

  ListTile _drawerItem(String title,
      AdminHomeState state, AdminHomeController controller) => ListTile(
    onTap: () {
      Navigator.pop(context);
      controller.changeState(state);
    },
    selected: controller.state == state,
    title: Text(title),
  );

  ListTile _drawerItemLogout(AdminHomeController controller) => ListTile(
    onTap: () {
      Navigator.pop(context);
      controller.onLogout();
    },
    title: const Text('Logout'),
  );
}