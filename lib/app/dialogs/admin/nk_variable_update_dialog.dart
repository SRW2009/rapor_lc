
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/ui/nk-variable/setting_nk_variable_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

class NKVariableUpdateDialog extends StatefulWidget {
  final MataPelajaran nkVariable;
  final Function(MataPelajaran) onSave;
  final SettingNKVariableController controller;

  const NKVariableUpdateDialog({
    Key? key,
    required this.onSave,
    required this.controller,
    required this.nkVariable,
  }) : super(key: key);

  @override
  State<NKVariableUpdateDialog> createState() => _NKVariableUpdateDialogState();
}

class _NKVariableUpdateDialogState extends State<NKVariableUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _nameCon;

  @override
  void initState() {
    _nameCon = TextEditingController(text: widget.nkVariable.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah Variabel NK',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputField(
                  label: 'Nama Variabel',
                  controller: _nameCon,
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            MataPelajaran(widget.nkVariable.id, _nameCon.text,
              divisi: widget.nkVariable.divisi,
            ),
          ),
        ),
      ],
    );
  }
}