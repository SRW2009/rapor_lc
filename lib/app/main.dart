import 'package:flutter/material.dart';
import 'package:rapor_lc/app/pages/splash/splash_view.dart';
import 'package:rapor_lc/app/utils/router.dart' as r;

void main() {
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
      home: SplashPage(),
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }
}