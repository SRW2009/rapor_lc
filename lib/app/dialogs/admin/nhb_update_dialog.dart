
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nhb/admin_home_nhb_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class NHBUpdateDialog extends StatefulWidget {
  final NHB nhb;
  final Function(NHB) onSave;
  final AdminHomeNHBController controller;

  const NHBUpdateDialog({Key? key, required this.nhb, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NHBUpdateDialog> createState() => _NHBUpdateDialogState();
}

class _NHBUpdateDialogState extends State<NHBUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _idCon;
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
    _idCon = TextEditingController(text: widget.nhb.id.toString());
    _santriCon = widget.nhb.santri;
    _mapelCon = widget.nhb.mataPelajaran;
    _semesterCon = TextEditingController(text: widget.nhb.semester.toString());
    _tahunAjaranCon = TextEditingController(text: widget.nhb.tahunAjaran);
    _nilaiHarianCon = TextEditingController(text: widget.nhb.nilaiHarian.toString());
    _nilaiBulananCon = TextEditingController(text: widget.nhb.nilaiBulanan.toString());
    _nilaiProjectCon = TextEditingController(text: widget.nhb.nilaiProject.toString());
    _nilaiAkhirCon = TextEditingController(text: widget.nhb.nilaiAkhir.toString());
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
                FormDropdownSearch<MataPelajaran>(
                  label: 'Mata Pelajaran',
                  compareFn: (o1, o2) => o1?.id == o2?.id,
                  onFind: widget.controller.dialogOnFindMapel,
                  showItem: (e) => '${e.id} - ${e.namaMapel}',
                  onPick: (val) => _mapelCon = val,
                  selectedItem: () => _mapelCon,
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
            NHB(widget.nhb.id, _santriCon!, int.tryParse(_semesterCon.text)!,
                _tahunAjaranCon.text, _mapelCon!, int.tryParse(_nilaiHarianCon.text)!,
                int.tryParse(_nilaiBulananCon.text)!, int.tryParse(_nilaiProjectCon.text)!,
                int.tryParse(_nilaiAkhirCon.text)!, int.tryParse(_akumulasiCon.text)!,
                _predikatCon.text)
          ),
        ),
      ],
    );
  }
}