
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/client-col/manage-nk/manage_nk_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nk.dart';

class ClientNKUpdateDialog extends StatefulWidget {
  final NK nk;
  final Function(NK) onSave;
  final ManageNKController controller;

  const ClientNKUpdateDialog({Key? key, required this.nk, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<ClientNKUpdateDialog> createState() => _ClientNKUpdateDialogState();
}

class _ClientNKUpdateDialogState extends State<ClientNKUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _noCon;
  late final TextEditingController _variabelCon;
  late final TextEditingController _nilaiMesjidCon;
  late final TextEditingController _nilaiKelasCon;
  late final TextEditingController _nilaiAsramaCon;
  late final TextEditingController _akumulatifCon;
  late final TextEditingController _predikatCon;
  late final TextEditingController _noteCon;

  @override
  void initState() {
    _noCon = TextEditingController(text: widget.nk.no.toString());
    _variabelCon = TextEditingController(text: widget.nk.nama_variabel);
    _nilaiMesjidCon = TextEditingController(text: widget.nk.nilai_mesjid.toString());
    _nilaiKelasCon = TextEditingController(text: widget.nk.nilai_kelas.toString());
    _nilaiAsramaCon = TextEditingController(text: widget.nk.nilai_asrama.toString());
    _akumulatifCon = TextEditingController(text: widget.nk.akumulatif.toString());
    _predikatCon = TextEditingController(text: widget.nk.predikat);
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
            NK(widget.nk.no, _variabelCon.text,
                int.tryParse(_nilaiMesjidCon.text)!, int.tryParse(_nilaiKelasCon.text)!,
                int.tryParse(_nilaiAsramaCon.text)!, int.tryParse(_akumulatifCon.text)!,
                _predikatCon.text, note: _noteCon.text)
          ),
        ),
      ],
    );
  }
}