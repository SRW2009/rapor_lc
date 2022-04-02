
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/npb/admin_npb_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_radios.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';

class NPBCreateDialog extends StatefulWidget {
  final Function(NPB) onSave;
  final AdminNPBController controller;

  const NPBCreateDialog({Key? key, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NPBCreateDialog> createState() => _NPBCreateDialogState();
}

class _NPBCreateDialogState extends State<NPBCreateDialog> {
  final _key = GlobalKey<FormState>();
  /// 0 is Masa Observasi, 1 is Paska Observasi
  int _npbTypeCon = 0;
  MataPelajaran? _mapelCon;
  late final TextEditingController _presensiCon;
  late final TextEditingController _nCon;
  late final TextEditingController _noteCon;

  @override
  void initState() {
    _presensiCon = TextEditingController();
    _nCon = TextEditingController();
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
                FormInputFieldRadios(
                  label: 'Tipe',
                  value: _npbTypeCon,
                  onChanged: (val) {
                    setState(() {
                      _npbTypeCon = val;
                    });
                  },
                  contents: const ['NPBMO', 'NPBPO'],
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
                if (_npbTypeCon == 0)
                  FormInputFieldNumber('n', _nCon,),
                FormInputField(
                  label: 'Catatan',
                  controller: _noteCon,
                  inputType: TextInputType.multiline,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            (_npbTypeCon == 0)
                ? NPBMO(0, _mapelCon!, _presensiCon.text, int.tryParse(_nCon.text)!, note: _noteCon.text)
                : NPBPO(0, _mapelCon!, _presensiCon.text, note: _noteCon.text)
          ),
        ),
      ],
    );
  }
}