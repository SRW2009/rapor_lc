
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_button.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_checkbox.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_timeline.dart';
import 'package:rapor_lc/common/print_settings.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';

class PrintDialog extends StatefulWidget {
  final Function(PrintSettings settings) onSave;

  const PrintDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  State<PrintDialog> createState() => _PrintDialogState();
}

class _PrintDialogState extends State<PrintDialog> {
  String? headerPath;
  Timeline fromTimelineCon = Timeline.initial();
  Timeline toTimelineCon = Timeline.initial();
  bool nhbSemesterPage = true;
  bool nhbBlockPage = true;
  bool npbPage = true;
  bool nkPage = true;
  bool nkAdvicePage = true;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Print Settings',
      contents: [
        FormDropdownButton<String>(
          value: headerPath,
          label: 'Header Rapor',
          setState: (val) => setState(() {
            headerPath = val;
          }),
          errorMsg: 'Pilih Header rapor yang dibutuhkan.',
          items: [
            DropdownMenuItem(
              value: 'assets/images/rapor_header_qbs.png',
              child: Text('QBS'),
            ),
            DropdownMenuItem(
              value: 'assets/images/rapor_header_fq.png',
              child: Text('FQ'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        FormInputTimeline(
          label: 'From Timeline',
          inputBulan: false,
          timeline: fromTimelineCon,
          onChanged: (val) {
            setState(() {
              fromTimelineCon = val;
            });
          },
        ),
        FormInputTimeline(
          label: 'To Timeline',
          inputBulan: false,
          timeline: toTimelineCon,
          onChanged: (val) {
            setState(() {
              toTimelineCon = val;
            });
          },
        ),
        const SizedBox(height: 8),
        FormInputFieldCheckBox(
          'Halaman NHB Semester',
          nhbSemesterPage,
          (val) {
            setState(() {
              nhbSemesterPage = val;
            });
          },
        ),
        const SizedBox(height: 4),
        FormInputFieldCheckBox(
          'Halaman NHB Block',
          nhbBlockPage,
              (val) {
            setState(() {
              nhbBlockPage = val;
            });
          },
        ),
        const SizedBox(height: 4),
        FormInputFieldCheckBox(
          'Halaman NPB',
          npbPage,
              (val) {
            setState(() {
              npbPage = val;
            });
          },
        ),
        const SizedBox(height: 4),
        FormInputFieldCheckBox(
          'Halaman NK',
          nkPage,
              (val) {
            setState(() {
              nkPage = val;
            });
          },
        ),
        const SizedBox(height: 4),
        FormInputFieldCheckBox(
          'Halaman Nasehat Dewan Guru',
          nkAdvicePage,
              (val) {
            setState(() {
              nkAdvicePage = val;
            });
          },
        ),
        BaseDialogActions(
          posButtonText: 'PRINT',
          onSave: () {
            var printSettings = PrintSettings(
              headerPath ?? 'assets/images/rapor_header_qbs.png',
              fromTimelineCon.toInt(),
              toTimelineCon.toInt(),
              nhbSemesterPage: nhbSemesterPage,
              nhbBlockPage: nhbBlockPage,
              npbPage: npbPage,
              nkPage: nkPage,
              nkAdvicePage: nkAdvicePage,
            );
            widget.onSave(printSettings);
          },
        ),
      ],
    );
  }
}
