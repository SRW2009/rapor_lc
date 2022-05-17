
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/manage-nhb/manage_nhb_controller.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';

class NHBCreateDialog extends StatefulWidget {
  final Function(NHB) onSave;
  final ManageNHBController controller;
  final int lastIndex;

  const NHBCreateDialog({Key? key, required this.onSave, required this.controller, required this.lastIndex,
  }) : super(key: key);

  @override
  State<NHBCreateDialog> createState() => _NHBCreateDialogState();
}

class _NHBCreateDialogState extends State<NHBCreateDialog> {
  final _key = GlobalKey<FormState>();
  MataPelajaran? _mapelCon;
  late final TextEditingController _nilaiHarianCon;
  late final TextEditingController _nilaiBulananCon;
  late final TextEditingController _nilaiAkhirCon;
  // late final TextEditingController _nilaiProjekCon;

  @override
  void initState() {
    _nilaiHarianCon = TextEditingController();
    _nilaiBulananCon = TextEditingController();
    _nilaiAkhirCon = TextEditingController();
    // _nilaiProjekCon = TextEditingController();
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
              NHB(widget.lastIndex, _mapelCon!, nh, nb, -1, na, ak, pr),
            );
          },
        ),
      ],
    );
  }
}