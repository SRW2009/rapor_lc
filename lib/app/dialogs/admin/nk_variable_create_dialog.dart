
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/ui/nk-variable/setting_nk_variable_controller.dart';
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

class NKVariableCreateDialog extends StatefulWidget {
  final Function(MataPelajaran) onSave;
  final SettingNKVariableController controller;

  const NKVariableCreateDialog({
    Key? key,
    required this.onSave,
    required this.controller,
  }) : super(key: key);

  @override
  State<NKVariableCreateDialog> createState() => _NKVariableCreateDialogState();
}

class _NKVariableCreateDialogState extends State<NKVariableCreateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _nameCon;

  @override
  void initState() {
    _nameCon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah Variabel NK',
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
            MataPelajaran(0, _nameCon.text,
              divisi: LoadedSettings.divisiKesantrian!,
            ),
          ),
        ),
      ],
    );
  }
}