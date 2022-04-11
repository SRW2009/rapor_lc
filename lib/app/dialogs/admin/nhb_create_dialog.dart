
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin-col/nhb/admin_nhb_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';

class NHBCreateDialog extends StatefulWidget {
  final Function(NHB) onSave;
  final AdminNHBController controller;

  const NHBCreateDialog({Key? key, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NHBCreateDialog> createState() => _NHBCreateDialogState();
}

class _NHBCreateDialogState extends State<NHBCreateDialog> {
  final _key = GlobalKey<FormState>();
  MataPelajaran? _mapelCon;
  late final TextEditingController _nilaiHarianCon;
  late final TextEditingController _nilaiBulananCon;
  late final TextEditingController _nilaiProjekCon;
  late final TextEditingController _nilaiAkhirCon;
  late final TextEditingController _akumulasiCon;
  late final TextEditingController _predikatCon;

  @override
  void initState() {
    _nilaiHarianCon = TextEditingController();
    _nilaiBulananCon = TextEditingController();
    _nilaiProjekCon = TextEditingController();
    _nilaiAkhirCon = TextEditingController();
    _akumulasiCon = TextEditingController();
    _predikatCon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah NHB',
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
                FormInputFieldNumber('Nilai Harian', _nilaiHarianCon),
                FormInputFieldNumber('Nilai Bulanan', _nilaiBulananCon),
                FormInputFieldNumber('Nilai Projek', _nilaiProjekCon),
                FormInputFieldNumber('Nilai Akhir', _nilaiAkhirCon),
                FormInputFieldNumber('Akumulasi', _akumulasiCon),
                FormInputField(label: 'Predikat', controller: _predikatCon),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            NHB(0, _mapelCon!, int.tryParse(_nilaiHarianCon.text)!,
                int.tryParse(_nilaiBulananCon.text)!, int.tryParse(_nilaiProjekCon.text)!,
                int.tryParse(_nilaiAkhirCon.text)!, int.tryParse(_akumulasiCon.text)!,
                _predikatCon.text)
          ),
        ),
      ],
    );
  }
}