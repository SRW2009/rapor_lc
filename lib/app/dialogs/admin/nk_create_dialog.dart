
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nk/admin_home_nk_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class NKCreateDialog extends StatefulWidget {
  final Function(NK) onSave;
  final AdminHomeNKController controller;

  const NKCreateDialog({Key? key, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NKCreateDialog> createState() => _NKCreateDialogState();
}

class _NKCreateDialogState extends State<NKCreateDialog> {
  final _key = GlobalKey<FormState>();
  Santri? _santriCon;
  late final TextEditingController _bulanCon;
  late final TextEditingController _semesterCon;
  late final TextEditingController _tahunAjaranCon;
  late final TextEditingController _variabelCon;
  late final TextEditingController _nilaiMesjidCon;
  late final TextEditingController _nilaiKelasCon;
  late final TextEditingController _nilaiAsramaCon;
  late final TextEditingController _akumulatifCon;
  late final TextEditingController _predikatCon;

  @override
  void initState() {
    _bulanCon = TextEditingController();
    _semesterCon = TextEditingController();
    _tahunAjaranCon = TextEditingController();
    _variabelCon = TextEditingController();
    _nilaiMesjidCon = TextEditingController();
    _nilaiKelasCon = TextEditingController();
    _nilaiAsramaCon = TextEditingController();
    _akumulatifCon = TextEditingController();
    _predikatCon = TextEditingController();
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
                FormDropdownSearch<Santri>(
                  label: 'Santri',
                  compareFn: (o1, o2) => o1?.nis == o2?.nis,
                  onFind: widget.controller.dialogOnFindSantri,
                  showItem: (e) => '${e.nis} - ${e.nama}',
                  onPick: (val) => _santriCon = val,
                ),
                FormInputFieldNumber('Bulan', _bulanCon),
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
                FormInputField(label: 'Nama Variabel', controller: _variabelCon),
                FormInputFieldNumber('Nilai Mesjid', _nilaiMesjidCon),
                FormInputFieldNumber('Nilai Kelas', _nilaiKelasCon),
                FormInputFieldNumber('Nilai Asrama', _nilaiAsramaCon),
                FormInputFieldNumber('Akumulatif', _akumulatifCon),
                FormInputField(label: 'Predikat', controller: _predikatCon),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            NK(0, _santriCon!, int.tryParse(_semesterCon.text)!,
                _tahunAjaranCon.text, int.tryParse(_bulanCon.text)!, _variabelCon.text,
                int.tryParse(_nilaiMesjidCon.text)!, int.tryParse(_nilaiKelasCon.text)!,
                int.tryParse(_nilaiAsramaCon.text)!, int.tryParse(_akumulatifCon.text)!,
                _predikatCon.text)
          ),
        ),
      ],
    );
  }
}