
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/manage-nk/manage_nk_controller.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nk.dart';

class NKCreateDialog extends StatefulWidget {
  final int lastIndex;
  final Function(NK) onSave;
  final ManageNKController controller;

  const NKCreateDialog({Key? key, 
    required this.onSave, required this.controller, required this.lastIndex,
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
  late final TextEditingController _noteCon;

  @override
  void initState() {
    _variabelCon = TextEditingController();
    _nilaiMesjidCon = TextEditingController();
    _nilaiKelasCon = TextEditingController();
    _nilaiAsramaCon = TextEditingController();
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
                FormDropdownSearch<MataPelajaran>(
                  label: 'Nama Variabel',
                  compareFn: (o1, o2) => o1?.id == o2?.id,
                  onFind: widget.controller.dialogOnFindNKVars,
                  showItem: (e) => e.name,
                  onPick: (val) => setState(() => _variabelCon.text = val.name),
                ),
                FormInputFieldNumber('Nilai Mesjid', _nilaiMesjidCon),
                FormInputFieldNumber('Nilai Kelas', _nilaiKelasCon),
                FormInputFieldNumber('Nilai Asrama', _nilaiAsramaCon),
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
          onSave: () {
            var nm = int.tryParse(_nilaiMesjidCon.text)!;
            var nk = int.tryParse(_nilaiKelasCon.text)!;
            var na = int.tryParse(_nilaiAsramaCon.text)!;
            var ak = NilaiCalculation.accumulate([nm,nk,na]);
            var pr = NilaiCalculation.toPredicate(ak);
            return widget.onSave(
              NK(widget.lastIndex, _variabelCon.text, nm, nk, na, ak, pr, note: _noteCon.text)
            );
          },
        ),
      ],
    );
  }
}