
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/manage-nk/manage_nk_controller.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nk.dart';

class NKUpdateDialog extends StatefulWidget {
  final NK nk;
  final Function(NK) onSave;
  final ManageNKController controller;

  const NKUpdateDialog({Key? key, required this.nk, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NKUpdateDialog> createState() => _NKUpdateDialogState();
}

class _NKUpdateDialogState extends State<NKUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _noCon;
  late final TextEditingController _variabelCon;
  late final TextEditingController _nilaiMesjidCon;
  late final TextEditingController _nilaiKelasCon;
  late final TextEditingController _nilaiAsramaCon;
  late final TextEditingController _noteCon;

  @override
  void initState() {
    _noCon = TextEditingController(text: widget.nk.no.toString());
    _variabelCon = TextEditingController(text: widget.nk.nama_variabel);
    _nilaiMesjidCon = TextEditingController(text: widget.nk.nilai_mesjid.toString());
    _nilaiKelasCon = TextEditingController(text: widget.nk.nilai_kelas.toString());
    _nilaiAsramaCon = TextEditingController(text: widget.nk.nilai_asrama.toString());
    _noteCon = TextEditingController(text: widget.nk.note);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah NK',
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
                FutureBuilder<List<MataPelajaran>>(
                  future: widget.controller.dialogOnFindNKVars(''),
                  builder: (context, snapshot) {
                    return FormDropdownSearch<MataPelajaran>(
                      label: 'Nama Variabel',
                      compareFn: (o1, o2) => o1?.id == o2?.id,
                      onFind: widget.controller.dialogOnFindNKVars,
                      showItem: (e) => e.name,
                      onPick: (val) => setState(() => _variabelCon.text = val.name),
                      selectedItem: (snapshot.hasData)
                          ? () => snapshot.data!.firstWhere((element) => element.name == _variabelCon.text)
                          : null,
                    );
                  }
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
                NK(widget.nk.no, _variabelCon.text, nm, nk, na, ak.toInt(), pr, note: _noteCon.text)
            );
          },
        ),
      ],
    );
  }
}