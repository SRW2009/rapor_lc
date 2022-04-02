
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/divisi/admin_home_divisi_controller.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';

class DivisiUpdateDialog extends StatefulWidget {
  final Divisi divisi;
  final Function(Divisi) onSave;
  final AdminHomeDivisiController controller;

  const DivisiUpdateDialog({Key? key, required this.divisi, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<DivisiUpdateDialog> createState() => _DivisiUpdateDialogState();
}

class _DivisiUpdateDialogState extends State<DivisiUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _idCon;
  late final TextEditingController _namaCon;

  @override
  void initState() {
    _idCon = TextEditingController(text: widget.divisi.id.toString());
    _namaCon = TextEditingController(text: widget.divisi.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah Divisi',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputField(
                  label: 'ID',
                  controller: _idCon,
                  isDisabled: true,
                ),
                FormInputField(
                  label: 'Nama',
                  controller: _namaCon,
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            Divisi(widget.divisi.id, _namaCon.text),
          ),
        ),
      ],
    );
  }
}