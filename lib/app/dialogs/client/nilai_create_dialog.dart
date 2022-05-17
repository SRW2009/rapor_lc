
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_bas.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/bulan_and_semester.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class ClientNilaiCreateDialog extends StatefulWidget {
  final Santri santri;
  final Function(Nilai) onSave;

  const ClientNilaiCreateDialog({Key? key, required this.onSave, required this.santri,
  }) : super(key: key);

  @override
  State<ClientNilaiCreateDialog> createState() => _ClientNilaiCreateDialogState();
}

class _ClientNilaiCreateDialogState extends State<ClientNilaiCreateDialog> {
  final _key = GlobalKey<FormState>();
  late BulanAndSemester _BaSCon;
  late final TextEditingController _tahunAjaranCon;
  late final TextEditingController _santriCon;

  @override
  void initState() {
    _BaSCon = BulanAndSemester(0, 0);
    _tahunAjaranCon = TextEditingController();
    _santriCon =TextEditingController(text: widget.santri.name);
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
            Nilai(0, _BaSCon, _tahunAjaranCon.text, widget.santri),
          ),
        ),
      ],
    );
  }
}