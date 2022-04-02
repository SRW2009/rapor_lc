
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/santri/admin_home_santri_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

class SantriCreateDialog extends StatefulWidget {
  final Function(Santri) onSave;
  final AdminHomeSantriController controller;

  const SantriCreateDialog({Key? key, required this.onSave, required this.controller, //required this.context
  }) : super(key: key);

  @override
  State<SantriCreateDialog> createState() => _SantriCreateDialogState();
}

class _SantriCreateDialogState extends State<SantriCreateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _nisCon;
  late final TextEditingController _nameCon;

  @override
  void initState() {
    _nisCon = TextEditingController();
    _nameCon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah Santri',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputField(
                  label: 'NIS',
                  controller: _nisCon,
                  inputType: TextInputType.text,
                  validator: (s) {
                    if (s == null || s.isEmpty) return 'Harus Diisi';
                    return null;
                  },
                ),
                FormInputField(
                  label: 'Nama',
                  controller: _nameCon,
                  inputType: TextInputType.text,
                  validator: (s) {
                    if (s == null || s.isEmpty) return 'Harus Diisi';
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            Santri(0, _nameCon.text, nis: _nisCon.text),
          ),
        ),
      ],
    );
  }
}