
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client-col/home/home_controller.dart';
import 'package:rapor_lc/app/pages/client-col/home/ui/dashboard/home_dashboard_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_decoration.dart';
import 'package:rapor_lc/data/helpers/chart/chart_repo.dart';
import 'package:rapor_lc/data/test-repositories/santri_repo_impl.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

class HomeDashboardUI extends View {
  final HomeController? homeController;

  HomeDashboardUI({Key? key, required this.homeController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeDashboardUIView(homeController);
}

class AdminHomeDashboardUIView extends ViewState<HomeDashboardUI, HomeDashboardController> {
  AdminHomeDashboardUIView(homeController)
      : super(HomeDashboardController(
    SantriRepositoryImplTest(),
    ChartRepository(),
    homeController,
  ));

  @override
  Widget get view => Container(
    key: globalKey,
    child: ControlledWidgetBuilder<HomeDashboardController>(
      builder: (context, controller) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (controller.homeController.user == null) ..._unloadedUser(),
            if (controller.homeController.user != null)
              ..._loadedUser(controller.homeController.user!),
            ElevatedButton(
              onPressed: controller.homeController.onLogout,
              child: Text('Logout'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
          ],
        );
      }
    ),
  );

  List<Widget> _unloadedUser() {
    return [
      Center(
        child: CircularProgressIndicator(),
      ),
    ];
  }

  List<Widget> _loadedUser(Teacher user) {
    return [
      Image.asset(
        'assets/images/background.jpg',
        fit: BoxFit.cover,
        height: 200.0,
      ),
      TextField(
        controller: TextEditingController(text: user.name),
        readOnly: true,
        decoration: inputDecoration.copyWith(
          labelText: 'Nama',
        ),
      ),
      TextField(
        controller: TextEditingController(text: user.email),
        readOnly: true,
        decoration: inputDecoration.copyWith(
          labelText: 'Email',
        ),
      ),
    ];
  }
}