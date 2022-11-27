
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/common/nilai_calc.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb_semester.dart';

class NHBSemesterUpdateDialog extends StatefulWidget {
  final NHBSemester nhb;
  final Function(NHBSemester) onSave;
  final Future<List<MataPelajaran>> Function(String?) onFindMapel;

  const NHBSemesterUpdateDialog({Key? key, required this.nhb, required this.onSave, required this.onFindMapel,
  }) : super(key: key);

  @override
  State<NHBSemesterUpdateDialog> createState() => _NHBSemesterUpdateDialogState();
}

class _NHBSemesterUpdateDialogState extends State<NHBSemesterUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _noCon;
  MataPelajaran? _mapelCon;
  late final TextEditingController _nilaiHarianCon;
  late final TextEditingController _nilaiBulananCon;
  late final TextEditingController _nilaiProjekCon;
  late final TextEditingController _nilaiAkhirCon;

  @override
  void initState() {
    _noCon = TextEditingController(text: widget.nhb.no.toString());
    _mapelCon = widget.nhb.pelajaran;
    _nilaiHarianCon = TextEditingController(text: widget.nhb.nilai_harian.toString());
    _nilaiBulananCon = TextEditingController(text: widget.nhb.nilai_bulanan.toString());
    _nilaiProjekCon = TextEditingController(text: widget.nhb.nilai_projek.toString());
    _nilaiAkhirCon = TextEditingController(text: widget.nhb.nilai_akhir.toString());
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
                FormInputFieldNumber('Nilai Bulanan', _nilaiBulananCon),
                FormInputFieldNumberNullable('Nilai Projek', _nilaiProjekCon),
                FormInputFieldNumberNullable('Nilai Akhir', _nilaiAkhirCon),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () {
            var nh = int.tryParse(_nilaiHarianCon.text)!;
            var nb = int.tryParse(_nilaiBulananCon.text)!;
            var np = _nilaiProjekCon.text.isNotEmpty ? int.tryParse(_nilaiProjekCon.text)! : -1;
            var na = _nilaiAkhirCon.text.isNotEmpty ? int.tryParse(_nilaiAkhirCon.text)! : -1;
            var ak = NilaiCalculation.accumulate([nh,nb,np,na]);
            var pr = NilaiCalculation.toPredicate(ak);
            return widget.onSave(
              NHBSemester(widget.nhb.no, _mapelCon!, nh, nb, np, na, ak.toInt(), pr),
            );
          },
        ),
      ],
    );
  }
}