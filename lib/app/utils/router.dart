
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/pages/admin/home/admin_home_view.dart';
import 'package:rapor_lc/app/pages/pages.dart';
import 'package:rapor_lc/app/pages/splash/splash_view.dart';
import 'package:rapor_lc/app/pages/login/login_view.dart';

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
        //return _buildRoute(settings, HomePage());
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