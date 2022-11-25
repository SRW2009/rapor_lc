
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/divisi/admin_home_divisi_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_checkbox.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';

class DivisiCreateDialog extends StatefulWidget {
  final Function(Divisi) onSave;
  final AdminHomeDivisiController controller;

  const DivisiCreateDialog({Key? key, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<DivisiCreateDialog> createState() => _DivisiCreateDialogState();
}

class _DivisiCreateDialogState extends State<DivisiCreateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _namaCon;
  bool _isBlockCon = false;

  @override
  void initState() {
    _namaCon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah Divisi',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputField(
                  label: 'Nama',
                  controller: _namaCon,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: FormInputFieldCheckBox(
                    'Is Block System',
                    _isBlockCon,
                        (val) {
                      setState(() {
                        _isBlockCon = val;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            Divisi(0, _namaCon.text, _isBlockCon),
          ),
        ),
      ],
    );
  }
}