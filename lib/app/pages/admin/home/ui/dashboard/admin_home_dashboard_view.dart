
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/dashboard/admin_home_dashboard_controller.dart';
import 'package:rapor_lc/data/repositories/nhb_repo_impl.dart';
import 'package:rapor_lc/data/repositories/nk_repo_impl.dart';
import 'package:rapor_lc/data/repositories/npb_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';

class AdminHomeDashboardUI extends View {
  AdminHomeDashboardUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeDashboardUIView();
}

class AdminHomeDashboardUIView extends ViewState<AdminHomeDashboardUI, AdminHomeDashboardController> {
  AdminHomeDashboardUIView()
      : super(AdminHomeDashboardController(
      SantriRepositoryImpl(),
      NHBRepositoryImpl(),
      NKRepositoryImpl(),
      NPBRepositoryImpl())
  );

  @override
  Widget get view => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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