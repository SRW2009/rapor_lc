
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nk/admin_home_nk_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class NKUpdateDialog extends StatefulWidget {
  final NK nk;
  final Function(NK) onSave;
  final AdminHomeNKController controller;

  const NKUpdateDialog({Key? key, required this.nk, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NKUpdateDialog> createState() => _NKUpdateDialogState();
}

class _NKUpdateDialogState extends State<NKUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _idCon;
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
    _idCon = TextEditingController(text: widget.nk.id.toString());
    _santriCon = widget.nk.santri;
    _bulanCon = TextEditingController(text: widget.nk.bulan.toString());
    _semesterCon = TextEditingController(text: widget.nk.semester.toString());
    _tahunAjaranCon = TextEditingController(text: widget.nk.tahun_ajaran);
    _variabelCon = TextEditingController(text: widget.nk.nama_variabel);
    _nilaiMesjidCon = TextEditingController(text: widget.nk.nilai_mesjid.toString());
    _nilaiKelasCon = TextEditingController(text: widget.nk.nilai_kelas.toString());
    _nilaiAsramaCon = TextEditingController(text: widget.nk.nilai_asrama.toString());
    _akumulatifCon = TextEditingController(text: widget.nk.akumulatif.toString());
    _predikatCon = TextEditingController(text: widget.nk.predikat);
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
                  label: 'ID',
                  controller: _idCon,
                  isDisabled: true,
                ),
                FormDropdownSearch<Santri>(
                  label: 'Santri',
                  compareFn: (o1, o2) => o1?.nis == o2?.nis,
                  onFind: widget.controller.dialogOnFindSantri,
                  showItem: (e) => '${e.nis} - ${e.nama}',
                  onPick: (val) => _santriCon = val,
                  selectedItem: () => _santriCon,
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
            NK(widget.nk.id, _santriCon!, int.tryParse(_semesterCon.text)!,
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