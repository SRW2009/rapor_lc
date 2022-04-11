
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/dashboard/admin_home_dashboard_controller.dart';
import 'package:rapor_lc/data/helpers/chart/chart_repo.dart';
import 'package:rapor_lc/data/test-repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/data/test-repositories/santri_repo_impl.dart';

class AdminHomeDashboardUI extends View {
  AdminHomeDashboardUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeDashboardUIView();
}

class AdminHomeDashboardUIView extends ViewState<AdminHomeDashboardUI, AdminHomeDashboardController> {
  AdminHomeDashboardUIView()
      : super(AdminHomeDashboardController(
    SantriRepositoryImplTest(),
    NilaiRepositoryImplTest(),
    ChartRepository(),
  ));

  @override
  Widget get view => Container(
    key: globalKey,
    child: ControlledWidgetBuilder<AdminHomeDashboardController>(
      builder: (context, controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.blue,
                      child: Builder(
                        builder: (context) {
                          return Container();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Expanded(
                    child: Card(
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    ),
  );
}