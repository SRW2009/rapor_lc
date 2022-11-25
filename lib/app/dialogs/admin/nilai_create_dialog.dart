
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/nilai/admin_home_nilai_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_checkbox.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_timeline.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class NilaiCreateDialog extends StatefulWidget {
  final Function(Nilai) onSave;
  final AdminHomeNilaiController controller;

  const NilaiCreateDialog({Key? key, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NilaiCreateDialog> createState() => _NilaiCreateDialogState();
}

class _NilaiCreateDialogState extends State<NilaiCreateDialog> {
  final _key = GlobalKey<FormState>();
  late Timeline _timelineCon;
  late final TextEditingController _tahunAjaranCon;
  Santri? _santriCon;
  bool _isObservationCon = false;

  @override
  void initState() {
    _timelineCon = Timeline(0, 0, 0, 0);
    _tahunAjaranCon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah Nilai',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputTimeline(
                  timeline: _timelineCon,
                  onChanged: (val) {
                    setState(() {
                      _timelineCon = val;
                    });
                  },
                ),
                FormInputField(
                  label: 'Tahun Ajaran',
                  controller: _tahunAjaranCon,
                  hint: '2020/2021',
                  validator: (s) {
                    if (s == null || s.isEmpty) return 'Harus Diisi';
                    if (s.length != 9 || s.split('/').length != 2
                        || int.tryParse(s.substring(0,4)) == null
                        || int.tryParse(s.substring(5, 9)) == null) {
                      return 'Format Salah';
                    }
                    return null;
                  },
                ),
                FormDropdownSearch<Santri>(
                  label: 'Santri',
                  compareFn: (o1, o2) => o1 == o2,
                  onFind: widget.controller.dialogOnFindSantri,
                  showItem: (e) => '${e.nis} - ${e.name}',
                  onPick: (val) => _santriCon = val,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: FormInputFieldCheckBox(
                    'Is Observation',
                    _isObservationCon,
                        (val) {
                      setState(() {
                        _isObservationCon = val;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            Nilai(0, _timelineCon, _tahunAjaranCon.text, _santriCon!, isObservation: _isObservationCon),
          ),
        ),
      ],
    );
  }
}