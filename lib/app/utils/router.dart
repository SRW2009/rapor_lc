
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/pages/admin-col/home/admin_home_view.dart';
import 'package:rapor_lc/app/pages/client-col/home/home_view.dart';
import 'package:rapor_lc/app/pages/client-col/manage-nilai/manage_nilai_view.dart';
import 'package:rapor_lc/app/pages/login/login_view.dart';
import 'package:rapor_lc/app/pages/manage-nhb/manage_nhb_view.dart';
import 'package:rapor_lc/app/pages/manage-nk/manage_nk_view.dart';
import 'package:rapor_lc/app/pages/manage-npb/manage_npb_view.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/app/pages/splash/splash_view.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class Router {
  final RouteObserver<PageRoute> routeObserver;

  Router() : routeObserver = RouteObserver<PageRoute>();

  Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.splash:
        return _buildRoute(settings, SplashPage());
      case Pages.login:
        return _buildRoute(settings, LoginPage());
      case Pages.home:
        return _buildRoute(settings, HomePage());
      case Pages.manage_nilai:
        final arg = settings.arguments! as List;
        return _buildRoute(settings, ManageNilaiPage(arg[0], arg[1]));
      case Pages.manage_nhb:
        final arg = settings.arguments! as Nilai;
        return _buildRoute(settings, ManageNHBPage(nilai: arg));
      case Pages.manage_nk:
        final arg = settings.arguments! as Nilai;
        return _buildRoute(settings, ManageNKPage(nilai: arg));
      case Pages.manage_npb:
        final arg = settings.arguments! as Nilai;
        return _buildRoute(settings, ManageNPBPage(nilai: arg));
      case Pages.admin_home:
        return _buildRoute(settings, AdminHomePage());
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}