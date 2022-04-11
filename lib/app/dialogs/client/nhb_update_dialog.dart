
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/client-col/manage-nhb/manage_nhb_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';

class ClientNHBUpdateDialog extends StatefulWidget {
  final NHB nhb;
  final Function(NHB) onSave;
  final ManageNHBController controller;

  const ClientNHBUpdateDialog({Key? key, required this.nhb, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<ClientNHBUpdateDialog> createState() => _ClientNHBUpdateDialogState();
}

class _ClientNHBUpdateDialogState extends State<ClientNHBUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _noCon;
  MataPelajaran? _mapelCon;
  late final TextEditingController _nilaiHarianCon;
  late final TextEditingController _nilaiBulananCon;
  late final TextEditingController _nilaiProjectCon;
  late final TextEditingController _nilaiAkhirCon;
  late final TextEditingController _akumulasiCon;
  late final TextEditingController _predikatCon;

  @override
  void initState() {
    _noCon = TextEditingController(text: widget.nhb.no.toString());
    _mapelCon = widget.nhb.pelajaran;
    _nilaiHarianCon = TextEditingController(text: widget.nhb.nilai_harian.toString());
    _nilaiBulananCon = TextEditingController(text: widget.nhb.nilai_bulanan.toString());
    _nilaiProjectCon = TextEditingController(text: widget.nhb.nilai_projek.toString());
    _nilaiAkhirCon = TextEditingController(text: widget.nhb.nilai_akhir.toString());
    _akumulasiCon = TextEditingController(text: widget.nhb.akumulasi.toString());
    _predikatCon = TextEditingController(text: widget.nhb.predikat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah NHB',
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
                  selectedItem: () => _mapelCon,
                ),
                FormInputFieldNumber('Nilai Harian', _nilaiHarianCon),
                FormInputFieldNumber('Nilai Bulanan', _nilaiBulananCon),
                FormInputFieldNumber('Nilai Projek', _nilaiProjectCon),
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
            NHB(widget.nhb.no, _mapelCon!, int.tryParse(_nilaiHarianCon.text)!,
                int.tryParse(_nilaiBulananCon.text)!, int.tryParse(_nilaiProjectCon.text)!,
                int.tryParse(_nilaiAkhirCon.text)!, int.tryParse(_akumulasiCon.text)!,
                _predikatCon.text)
          ),
        ),
      ],
    );
  }
}