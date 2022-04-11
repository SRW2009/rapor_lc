
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin-col/nk/admin_nk_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/nk.dart';

class NKCreateDialog extends StatefulWidget {
  final Function(NK) onSave;
  final AdminNKController controller;

  const NKCreateDialog({Key? key, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NKCreateDialog> createState() => _NKCreateDialogState();
}

class _NKCreateDialogState extends State<NKCreateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _variabelCon;
  late final TextEditingController _nilaiMesjidCon;
  late final TextEditingController _nilaiKelasCon;
  late final TextEditingController _nilaiAsramaCon;
  late final TextEditingController _akumulatifCon;
  late final TextEditingController _predikatCon;
  late final TextEditingController _noteCon;

  @override
  void initState() {
    _variabelCon = TextEditingController();
    _nilaiMesjidCon = TextEditingController();
    _nilaiKelasCon = TextEditingController();
    _nilaiAsramaCon = TextEditingController();
    _akumulatifCon = TextEditingController();
    _predikatCon = TextEditingController();
    _noteCon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah NK',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputField(label: 'Nama Variabel', controller: _variabelCon),
                FormInputFieldNumber('Nilai Mesjid', _nilaiMesjidCon),
                FormInputFieldNumber('Nilai Kelas', _nilaiKelasCon),
                FormInputFieldNumber('Nilai Asrama', _nilaiAsramaCon),
                FormInputFieldNumber('Akumulatif', _akumulatifCon),
                FormInputField(label: 'Predikat', controller: _predikatCon),
                FormInputField(
                  label: 'Catatan',
                  controller: _noteCon,
                  inputType: TextInputType.multiline,
                  maxLines: 3,
                  validator: (s) => null,
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            NK(0, _variabelCon.text,
                int.tryParse(_nilaiMesjidCon.text)!, int.tryParse(_nilaiKelasCon.text)!,
                int.tryParse(_nilaiAsramaCon.text)!, int.tryParse(_akumulatifCon.text)!,
                _predikatCon.text, note: _noteCon.text)
          ),
        ),
      ],
    );
  }
}