
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_checkbox.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_timeline.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class ClientNilaiUpdateDialog extends StatefulWidget {
  final Nilai nilai;
  final Function(Nilai) onSave;

  const ClientNilaiUpdateDialog({Key? key, required this.nilai, required this.onSave,
  }) : super(key: key);

  @override
  State<ClientNilaiUpdateDialog> createState() => _ClientNilaiUpdateDialogState();
}

class _ClientNilaiUpdateDialogState extends State<ClientNilaiUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _idCon;
  late Timeline _timelineCon;
  late final TextEditingController _tahunAjaranCon;
  late final TextEditingController _santriCon;
  bool _isObservationCon = false;

  @override
  void initState() {
    _idCon = TextEditingController(text: widget.nilai.id.toString());
    _timelineCon = widget.nilai.timeline;
    _tahunAjaranCon = TextEditingController(text: widget.nilai.tahunAjaran);
    _santriCon =TextEditingController(text: widget.nilai.santri.name);
    _isObservationCon = widget.nilai.isObservation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah Nilai',
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
                FormInputField(
                  label: 'Santri',
                  controller: _santriCon,
                  isDisabled: true,
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
            Nilai(widget.nilai.id, _timelineCon, _tahunAjaranCon.text, widget.nilai.santri, isObservation: _isObservationCon),
          ),
        ),
      ],
    );
  }
}