
import 'dart:io';

import 'package:flutter/material.dart';

import 'app/utils/router.dart' as r;
import 'app/pages/pages.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final r.Router _router;

  MyApp({Key? key})
      : _router = r.Router(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rapor LC SI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Raleway',
      ),
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
      initialRoute: Pages.splash,
    );
  }
}