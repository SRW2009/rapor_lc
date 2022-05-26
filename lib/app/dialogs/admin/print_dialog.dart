
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_button.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/common/print_settings.dart';

class PrintDialog extends StatefulWidget {
  final Function(PrintSettings settings) onSave;

  const PrintDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  State<PrintDialog> createState() => _PrintDialogState();
}

class _PrintDialogState extends State<PrintDialog> {
  String? headerPath;
  var fromSeController = TextEditingController();
  var toSeController = TextEditingController();

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
        Row(
          children: [
            Expanded(
              child: FormInputFieldNumber('Dari Semester', fromSeController),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: FormInputFieldNumber('Hingga Semester', toSeController),
            ),
          ],
        ),
        BaseDialogActions(
          posButtonText: 'PRINT',
          onSave: () {
            var printSettings = PrintSettings(
              headerPath ?? 'assets/images/rapor_header_qbs.png',
              int.tryParse(fromSeController.text) ?? 1,
              int.tryParse(toSeController.text) ?? 6,
            );
            widget.onSave(printSettings);
          },
        ),
      ],
    );
  }
}
