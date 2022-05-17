
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/dashboard/admin_home_dashboard_controller.dart';
import 'package:rapor_lc/data/helpers/chart/chart_repo.dart';
import 'package:rapor_lc/data/repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';

import 'package:rapor_lc/rapor_pdf_layout/pages/root.dart';
import 'package:rapor_lc/dummy_data/dummies.dart' as d;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AdminHomeDashboardUI extends View {
  AdminHomeDashboardUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeDashboardUIView();
}

class AdminHomeDashboardUIView extends ViewState<AdminHomeDashboardUI, AdminHomeDashboardController> {
  AdminHomeDashboardUIView()
      : super(AdminHomeDashboardController(
    SantriRepositoryImpl(),
    NilaiRepositoryImpl(),
    ChartRepository(),
  ));

  @override
  Widget get view => Container(
    key: globalKey,
    child: ControlledWidgetBuilder<AdminHomeDashboardController>(
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
                          return ElevatedButton(
                            onPressed: () async {
                              final headerImage = pw.MemoryImage(
                                (await rootBundle.load('assets/images/rapor_header_qbs.png')).buffer.asUint8List(),
                              );

                              final doc = pw.Document();
                              doc.addPage(page_title);
                              doc.addPage(page_nhb(headerImage, [d.nilai_s_odd, d.nilai_s_even]));
                              doc.addPage(page_npb_chart(headerImage, [d.nilai_s_odd, d.nilai_s_even]));
                              doc.addPage(page_npb_table(headerImage, [d.nilai_s_odd, d.nilai_s_even]));
                              doc.addPage(page_npb_chart(headerImage, [d.nilai_s_odd, d.nilai_s_even], isIT: true));
                              doc.addPage(page_npb_table(headerImage, [d.nilai_s_odd, d.nilai_s_even], isIT: true));
                              doc.addPage(page_nk(headerImage, [d.nilai_s_odd, d.nilai_s_even]));
                              doc.addPage(page_nk_advice(headerImage));
                              doc.addPage(page_nhb(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2));
                              doc.addPage(page_npb_chart(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2));
                              doc.addPage(page_npb_table(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2));
                              doc.addPage(page_npb_chart(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2, isIT: true));
                              doc.addPage(page_npb_table(headerImage, [d.nilai_s_odd, d.nilai_s_even], semester: 2, isIT: true));
                              doc.addPage(page_nk(headerImage, [d.nilai_s_odd, d.nilai_s_even, d.nilai_s_even2, d.nilai_s_even3], semester: 2));
                              doc.addPage(page_nk_advice(headerImage));
                              await Printing.layoutPdf(
                                  onLayout: (PdfPageFormat format) async => doc.save());
                            },
                            child: const Text('PRINT!'),
                          );
                        },
                      ),
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