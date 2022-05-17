
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/manage-nhb/manage_nhb_controller.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';

class NHBUpdateDialog extends StatefulWidget {
  final NHB nhb;
  final Function(NHB) onSave;
  final ManageNHBController controller;

  const NHBUpdateDialog({Key? key, required this.nhb, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NHBUpdateDialog> createState() => _NHBUpdateDialogState();
}

class _NHBUpdateDialogState extends State<NHBUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _noCon;
  MataPelajaran? _mapelCon;
  late final TextEditingController _nilaiHarianCon;
  late final TextEditingController _nilaiBulananCon;
  late final TextEditingController _nilaiAkhirCon;
  // late final TextEditingController _nilaiProjectCon;

  @override
  void initState() {
    _noCon = TextEditingController(text: widget.nhb.no.toString());
    _mapelCon = widget.nhb.pelajaran;
    _nilaiHarianCon = TextEditingController(text: widget.nhb.nilai_harian.toString());
    _nilaiBulananCon = TextEditingController(text: widget.nhb.nilai_bulanan.toString());
    _nilaiAkhirCon = TextEditingController(text: widget.nhb.nilai_akhir.toString());
    // _nilaiProjectCon = TextEditingController(text: widget.nhb.nilai_projek.toString());
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
                FormInputFieldNumberNullable('Nilai Akhir', _nilaiAkhirCon),
                // FormInputFieldNumber('Nilai Projek', _nilaiProjekCon),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () {
            var nh = int.tryParse(_nilaiHarianCon.text)!;
            var nb = int.tryParse(_nilaiBulananCon.text)!;
            var na = _nilaiAkhirCon.text.isNotEmpty ? int.tryParse(_nilaiAkhirCon.text)! : -1;
            var ak = NilaiCalculation.accumulate([nh,nb,if(na!=-1)na]);
            var pr = NilaiCalculation.toPredicate(ak);
            return widget.onSave(
              NHB(widget.nhb.no, _mapelCon!, nh, nb, -1, na, ak, pr),
            );
          },
        ),
      ],
    );
  }
}