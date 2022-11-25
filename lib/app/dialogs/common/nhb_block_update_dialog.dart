
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb_block.dart';

class NHBBlockUpdateDialog extends StatefulWidget {
  final NHBBlock nhb;
  final Function(NHBBlock) onSave;
  final Future<List<MataPelajaran>> Function(String?) onFindMapel;

  const NHBBlockUpdateDialog({Key? key, required this.nhb, required this.onSave, required this.onFindMapel,
  }) : super(key: key);

  @override
  State<NHBBlockUpdateDialog> createState() => _NHBBlockUpdateDialogState();
}

class _NHBBlockUpdateDialogState extends State<NHBBlockUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _noCon;
  MataPelajaran? _mapelCon;
  late final TextEditingController _nilaiHarianCon;
  late final TextEditingController _nilaiProjekCon;
  late final TextEditingController _nilaiAkhirCon;
  late final TextEditingController _descriptionCon;

  @override
  void initState() {
    _noCon = TextEditingController(text: widget.nhb.no.toString());
    _mapelCon = widget.nhb.pelajaran;
    _nilaiHarianCon = TextEditingController(text: widget.nhb.nilai_harian.toString());
    _nilaiProjekCon = TextEditingController(text: widget.nhb.nilai_projek.toString());
    _nilaiAkhirCon = TextEditingController(text: widget.nhb.nilai_akhir.toString());
    _descriptionCon = TextEditingController(text: widget.nhb.description.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah NHB Semester',
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
                  onFind: widget.onFindMapel,
                  showItem: (e) => '${e.id} - ${e.name}',
                  onPick: (val) => _mapelCon = val,
                  selectedItem: () => _mapelCon,
                ),
                FormInputFieldNumber('Nilai Harian', _nilaiHarianCon),
                FormInputFieldNumberNullable('Nilai Projek', _nilaiProjekCon),
                FormInputFieldNumberNullable('Nilai Akhir', _nilaiAkhirCon),
                FormInputField(
                  label: 'Deskripsi',
                  controller: _descriptionCon,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () {
            var nh = int.tryParse(_nilaiHarianCon.text)!;
            var np = _nilaiProjekCon.text.isNotEmpty ? int.tryParse(_nilaiProjekCon.text)! : -1;
            var na = _nilaiAkhirCon.text.isNotEmpty ? int.tryParse(_nilaiAkhirCon.text)! : -1;
            var ak = NilaiCalculation.accumulate([nh,np,na]);
            var pr = NilaiCalculation.toPredicate(ak);
            var desc = _descriptionCon.text;
            return widget.onSave(
              NHBBlock(widget.nhb.no, _mapelCon!, nh, np, na, ak.toInt(), pr, desc),
            );
          },
        ),
      ],
    );
  }
}