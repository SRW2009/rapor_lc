
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/pages/pages.dart';

class Router {
  final RouteObserver<PageRoute> routeObserver;

  Router() : routeObserver = RouteObserver<PageRoute>();

  Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.splash:

      case Pages.home:
        return _buildRoute(settings, HomePage());
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