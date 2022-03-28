
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client/home/ui/dashboard/home_dashboard_controller.dart';
import 'package:rapor_lc/data/helpers/chart/chart_repo.dart';
import 'package:rapor_lc/data/repositories/nhb_repo_impl.dart';
import 'package:rapor_lc/data/repositories/nk_repo_impl.dart';
import 'package:rapor_lc/data/repositories/npb_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeDashboardUI extends View {
  HomeDashboardUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeDashboardUIView();
}

class AdminHomeDashboardUIView extends ViewState<HomeDashboardUI, HomeDashboardController> {
  AdminHomeDashboardUIView()
      : super(HomeDashboardController(
    SantriRepositoryImpl(),
    NHBRepositoryImpl(),
    NKRepositoryImpl(),
    NPBRepositoryImpl(),
    ChartRepository(),
  ));

  @override
  Widget get view => Container(
    key: globalKey,
    child: ControlledWidgetBuilder<HomeDashboardController>(
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