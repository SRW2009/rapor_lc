import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:rapor_lc/rapor_print_layout/pages/root.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

      ],
      child: MaterialApp(
        title: 'Rapor LC SI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
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
      body: ListView(
        padding: const EdgeInsets.all(30.0),
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
    );
  }
}
