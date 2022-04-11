
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_bas.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/bulan_and_semester.dart';
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
  late BulanAndSemester _BaSCon;
  late final TextEditingController _tahunAjaranCon;
  late final TextEditingController _santriCon;

  @override
  void initState() {
    _idCon = TextEditingController(text: widget.nilai.id.toString());
    _BaSCon = widget.nilai.BaS;
    _tahunAjaranCon = TextEditingController(text: widget.nilai.tahunAjaran);
    _santriCon =TextEditingController(text: widget.nilai.santri.name);
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
                FormInputBaS(
                  BaS: _BaSCon,
                  onChanged: (val) {
                    setState(() {
                      _BaSCon = val;
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
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            Nilai(widget.nilai.id, _BaSCon, _tahunAjaranCon.text, widget.nilai.santri),
          ),
        ),
      ],
    );
  }
}