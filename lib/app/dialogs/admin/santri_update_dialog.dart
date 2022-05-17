
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/santri/admin_home_santri_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class SantriUpdateDialog extends StatefulWidget {
  final Santri santri;
  final Function(Santri) onSave;
  final AdminHomeSantriController controller;

  const SantriUpdateDialog({Key? key, required this.santri,
    required this.onSave, required this.controller}) : super(key: key);

  @override
  State<SantriUpdateDialog> createState() => _SantriUpdateDialogState();
}

class _SantriUpdateDialogState extends State<SantriUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _idCon;
  late final TextEditingController _nisCon;
  late final TextEditingController _nameCon;

  @override
  void initState() {
    _idCon = TextEditingController(text: widget.santri.id.toString());
    _nisCon = TextEditingController(text: widget.santri.nis);
    _nameCon = TextEditingController(text:  widget.santri.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah Santri',
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
                  label: 'NIS',
                  controller: _nisCon,
                ),
                FormInputField(
                  label: 'Nama',
                  controller: _nameCon,
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            Santri(widget.santri.id, _nameCon.text, nis: _nisCon.text),
          ),
        ),
      ],
    );
  }
}