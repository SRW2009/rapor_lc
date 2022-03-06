
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/home/admin_home_controller.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/dashboard/admin_home_dashboard_view.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nhb/admin_home_nhb_view.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nk/admin_home_nk_view.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/npb/admin_home_npb_view.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/santri/admin_home_santri_view.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/user/admin_home_user_view.dart';
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
              accountName: Text(controller.user?.email ?? ''),
              accountEmail: Text(controller.user?.getStatusName ?? ''),
            ),
            _drawerItem('Dashboard', AdminHomeState.dashboard, controller),
            _drawerItem('Santri', AdminHomeState.santri, controller),
            _drawerItem('NHB', AdminHomeState.nhb, controller),
            _drawerItem('NK', AdminHomeState.nk, controller),
            _drawerItem('NPB', AdminHomeState.npb, controller),
            _drawerItem('User', AdminHomeState.user, controller),
          ],
        ),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ControlledWidgetBuilder<AdminHomeController>(
        builder: (context, controller) => _uiView(controller.state),
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

  Widget _uiView(AdminHomeState state) {
    switch (state) {
      case AdminHomeState.dashboard:
        return AdminHomeDashboardUI();
      case AdminHomeState.santri:
        return AdminHomeSantriUI();
      case AdminHomeState.nhb:
        return AdminHomeNHBUI();
      case AdminHomeState.nk:
        return AdminHomeNKUI();
      case AdminHomeState.npb:
        return AdminHomeNPBUI();
      case AdminHomeState.user:
        return AdminHomeUserUI();
      default:
        return Container();
    }
  }
}