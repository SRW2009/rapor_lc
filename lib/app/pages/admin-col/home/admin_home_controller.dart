
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/admin_home_presenter.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/admin/admin_home_admin_view.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/dashboard/admin_home_dashboard_view.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/divisi/admin_home_divisi_view.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/mapel/admin_home_mapel_view.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/nilai/admin_home_nilai_view.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/relation/admin_home_relation_view.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/santri/admin_home_santri_view.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/teacher/admin_home_teacher_view.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/domain/entities/abstract/user.dart';

enum AdminHomeState { dashboard, santri, teacher, admin, mapel, divisi, nilai, relasi }

class AdminHomeController extends Controller {
  AdminHomeState state = AdminHomeState.dashboard;
  User? user;

  final AdminHomePresenter _presenter;
  AdminHomeController(authRepo)
      : _presenter = AdminHomePresenter(authRepo),
        super();

  void _getCurrentUserOnNext(User? user) {
    this.user = user;
    refreshUI();
  }

  void _logoutOnComplete() {
    Navigator.of(getContext())
        .pushReplacementNamed(Pages.login);
  }

  @override
  void initListeners() {
    _presenter.getCurrentUserOnNext = _getCurrentUserOnNext;
    _presenter.logoutOnComplete = _logoutOnComplete;
  }

  void _doGetCurrentUser() => _presenter.doGetCurrentUser();
  void _doLogout() => _presenter.doLogout();

  void onLogout() async {
    final result = await showDialog<bool>(
      context: getContext(),
      builder: (context) => AlertDialog(
        title: const Text('Perhatian'),
        content: const Text('Apa anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('TIDAK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('YA'),
          ),
        ],
      ),
    );
    if (result ?? false) _doLogout();
  }

  void changeState(AdminHomeState state) {
    this.state = state;
    refreshUI();
  }

  Widget getUiView(AdminHomeController controller) {
    switch (controller.state) {
      case AdminHomeState.dashboard:
        return AdminHomeDashboardUI();
      case AdminHomeState.santri:
        return AdminHomeSantriUI();
      case AdminHomeState.teacher:
        return AdminHomeTeacherUI();
      case AdminHomeState.admin:
        return AdminHomeAdminUI();
      case AdminHomeState.mapel:
        return AdminHomeMataPelajaranUI();
      case AdminHomeState.divisi:
        return AdminHomeDivisiUI();
      case AdminHomeState.nilai:
        return AdminHomeNilaiUI();
      case AdminHomeState.relasi:
        return AdminHomeRelationUI();
      default:
        return Container();
    }
  }

  @override
  void onInitState() {
    _doGetCurrentUser();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }
}