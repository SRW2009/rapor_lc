
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/client-col/manage-npb/manage_npb_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_radios.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';

class ClientNPBUpdateDialog extends StatefulWidget {
  final NPB npb;
  final Function(NPB) onSave;
  final ManageNPBController controller;

  const ClientNPBUpdateDialog({Key? key,
    required this.npb, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<ClientNPBUpdateDialog> createState() => _ClientNPBUpdateDialogState();
}

class _ClientNPBUpdateDialogState extends State<ClientNPBUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _noCon;
  /// 0 is Masa Observasi, 1 is Paska Observasi
  int _npbTypeCon = 0;
  MataPelajaran? _mapelCon;
  late final TextEditingController _presensiCon;
  late final TextEditingController _nCon;
  late final TextEditingController _noteCon;

  @override
  void initState() {
    _noCon = TextEditingController(text: widget.npb.no.toString());
    _presensiCon = TextEditingController(text: widget.npb.presensi);
    _nCon = TextEditingController(text: widget.npb.n.toString());
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
                  validator: (s) => null,
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
              (_npbTypeCon == 0)
                  ? NPBMO(widget.npb.no, _mapelCon!, _presensiCon.text, int.tryParse(_nCon.text)!, note: _noteCon.text)
                  : NPBPO(widget.npb.no, _mapelCon!, _presensiCon.text, note: _noteCon.text)
          ),
        ),
      ],
    );
  }
}