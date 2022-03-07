
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nhb/admin_home_nhb_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class NHBCreateDialog extends StatefulWidget {
  final Function(NHB) onSave;
  final AdminHomeNHBController controller;

  const NHBCreateDialog({Key? key, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NHBCreateDialog> createState() => _NHBCreateDialogState();
}

class _NHBCreateDialogState extends State<NHBCreateDialog> {
  final _key = GlobalKey<FormState>();
  Santri? _santriCon;
  MataPelajaran? _mapelCon;
  late final TextEditingController _semesterCon;
  late final TextEditingController _tahunAjaranCon;
  late final TextEditingController _nilaiHarianCon;
  late final TextEditingController _nilaiBulananCon;
  late final TextEditingController _nilaiProjectCon;
  late final TextEditingController _nilaiAkhirCon;
  late final TextEditingController _akumulasiCon;
  late final TextEditingController _predikatCon;

  @override
  void initState() {
    _semesterCon = TextEditingController();
    _tahunAjaranCon = TextEditingController();
    _nilaiHarianCon = TextEditingController();
    _nilaiBulananCon = TextEditingController();
    _nilaiProjectCon = TextEditingController();
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
                FormDropdownSearch<Santri>(
                  label: 'Santri',
                  compareFn: (o1, o2) => o1?.nis == o2?.nis,
                  onFind: widget.controller.dialogOnFindSantri,
                  showItem: (e) => e.nis,
                  onPick: (val) => _santriCon = val,
                ),
                FormDropdownSearch<MataPelajaran>(
                  label: 'Mata Pelajaran',
                  compareFn: (o1, o2) => o1?.id == o2?.id,
                  onFind: widget.controller.dialogOnFindMapel,
                  showItem: (e) => '${e.id} - ${e.namaMapel}',
                  onPick: (val) => _mapelCon = val,
                ),
                FormInputFieldNumber('Semester', _semesterCon),
                FormInputField(
                  label: 'Tahun Ajaran',
                  controller: _tahunAjaranCon,
                  hint: '2020/2021',
                  validator: (s) {
                    if (s == null || s.isEmpty) return 'Harus Diisi';
                    if (s.length != 9 && s.split('/').length != 2
                        && int.tryParse(s.substring(0,4)) == null
                        && int.tryParse(s.substring(5, 9)) == null) {
                      return 'Format Salah';
                    }
                    return null;
                  },
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
            NHB(0, _santriCon!, _mapelCon!, int.tryParse(_semesterCon.text)!,
                _tahunAjaranCon.text, int.tryParse(_nilaiHarianCon.text)!,
                int.tryParse(_nilaiBulananCon.text)!, int.tryParse(_nilaiProjectCon.text)!,
                int.tryParse(_nilaiAkhirCon.text)!, int.tryParse(_akumulasiCon.text)!,
                _predikatCon.text)
          ),
        ),
      ],
    );
  }
}