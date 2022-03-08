
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/npb/admin_home_npb_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_radios.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';
import 'package:rapor_lc/domain/entities/npbpo.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class NPBCreateDialog extends StatefulWidget {
  final Function(NPB) onSave;
  final AdminHomeNPBController controller;

  const NPBCreateDialog({Key? key, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NPBCreateDialog> createState() => _NPBCreateDialogState();
}

class _NPBCreateDialogState extends State<NPBCreateDialog> {
  final _key = GlobalKey<FormState>();
  /// 0 is Masa Observasi, 1 is Paska Observasi
  int _npbTypeCon = 0;
  Santri? _santriCon;
  MataPelajaran? _mapelCon;
  late final TextEditingController _semesterCon;
  late final TextEditingController _tahunAjaranCon;
  late final TextEditingController _presensiCon;
  late final TextEditingController _nCon;
  late final TextEditingController _noteCon;

  @override
  void initState() {
    _semesterCon = TextEditingController();
    _tahunAjaranCon = TextEditingController();
    _presensiCon = TextEditingController();
    _nCon = TextEditingController();
    _noteCon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah NPB',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputFieldRadios(
                  label: 'Tipe',
                  value: _npbTypeCon,
                  onChanged: (val) {
                    setState(() {
                      _npbTypeCon = val;
                    });
                  },
                  contents: const ['NPBMO', 'NPBPO'],
                ),
                FormDropdownSearch<Santri>(
                  label: 'Santri',
                  compareFn: (o1, o2) => o1?.nis == o2?.nis,
                  onFind: widget.controller.dialogOnFindSantri,
                  showItem: (e) => '${e.nis} - ${e.nama}',
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
                FormInputField(label: 'Presensi', controller: _presensiCon),
                if (_npbTypeCon == 0) FormInputField(
                  label: 'n',
                  controller: _nCon,
                ),
                FormInputField(
                  label: 'Catatan',
                  controller: _noteCon,
                  inputType: TextInputType.multiline,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            (_npbTypeCon == 0)
                ? NPBMO(0, _santriCon!, int.tryParse(_semesterCon.text)!, _tahunAjaranCon.text,
                _mapelCon!, int.tryParse(_nCon.text)!, _presensiCon.text, note: _noteCon.text)
                : NPBPO(0, _santriCon!, int.tryParse(_semesterCon.text)!, _tahunAjaranCon.text,
                _mapelCon!, _presensiCon.text, note: _noteCon.text)
          ),
        ),
      ],
    );
  }
}