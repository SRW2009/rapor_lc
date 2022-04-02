import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rapor_lc/rapor_pdf_layout/pages/root.dart';
import 'package:printing/printing.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final doc = pw.Document();

  @override
  void initState() {
    doc.addPage(page_title);
    doc.addPage(page_nhb());
    doc.addPage(page_npb_chart());
    doc.addPage(page_npb_table());
    doc.addPage(page_nk());
    doc.addPage(page_nk_advice());
    doc.addPage(page_nhb(semester: 2));
    doc.addPage(page_npb_chart(semester: 2));
    doc.addPage(page_npb_table(semester: 2));
    doc.addPage(page_nk(semester: 2));
    doc.addPage(page_nk_advice());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await Printing.layoutPdf(
                    onLayout: (PdfPageFormat format) async => doc.save());
              },
              child: const Text('PRINT!'),
            ),
            const SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () async {
                Directory appDocDir = await getApplicationDocumentsDirectory();
                String appDocPath = appDocDir.path;
                print(appDocPath);
                final file = File(appDocPath+"\\rapor_lc.pdf");
                await file.writeAsBytes(await doc.save());
              },
              child: const Text('SAVE!'),
            ),
          ],
        ),
      ),
    );
  }
}
