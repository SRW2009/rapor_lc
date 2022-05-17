
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/manage-npb/manage_npb_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

class NPBUpdateDialog extends StatefulWidget {
  final NPB npb;
  final Function(NPB) onSave;
  final ManageNPBController controller;

  const NPBUpdateDialog({Key? key,
    required this.npb, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NPBUpdateDialog> createState() => _NPBUpdateDialogState();
}

class _NPBUpdateDialogState extends State<NPBUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _noCon;
  MataPelajaran? _mapelCon;
  late final TextEditingController _presensiCon;
  late final TextEditingController _noteCon;

  @override
  void initState() {
    _noCon = TextEditingController(text: widget.npb.no.toString());
    _presensiCon = TextEditingController(text: widget.npb.presensi);
    _noteCon = TextEditingController(text: widget.npb.note);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah NPB',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputField(
                  label: 'Nomor',
                  controller: _noCon,
                  isDisabled: true,
                ),
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
              NPB(widget.npb.no, _mapelCon!, _presensiCon.text, note: _noteCon.text)
          ),
        ),
      ],
    );
  }
}