
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/manage-npb/manage_npb_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

class NPBCreateDialog extends StatefulWidget {
  final int lastIndex;
  final Function(NPB) onSave;
  final ManageNPBController controller;

  const NPBCreateDialog({Key? key,
    required this.lastIndex, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NPBCreateDialog> createState() => _NPBCreateDialogState();
}

class _NPBCreateDialogState extends State<NPBCreateDialog> {
  final _key = GlobalKey<FormState>();
  MataPelajaran? _mapelCon;
  late final TextEditingController _presensiCon;
  late final TextEditingController _noteCon;

  @override
  void initState() {
    _presensiCon = TextEditingController();
    _noteCon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah NPB',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormDropdownSearch<MataPelajaran>(
                  label: 'Mata Pelajaran',
                  compareFn: (o1, o2) => o1?.id == o2?.id,
                  onFind: widget.controller.dialogOnFindMapel,
                  showItem: (e) => '${e.id} - ${e.name}',
                  onPick: (val) => _mapelCon = val,
                ),
                FormInputField(
                  label: 'Presensi',
                  controller: _presensiCon,
                  hint: '0% - 100%',
                  maxLength: 4,
                ),
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
              NPB(widget.lastIndex, _mapelCon!, _presensiCon.text, note: _noteCon.text)
          ),
        ),
      ],
    );
  }
}