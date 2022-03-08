
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/mapel/admin_home_mapel_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_radios.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';

class MataPelajaranCreateDialog extends StatefulWidget {
  final Function(MataPelajaran) onSave;
  final AdminHomeMataPelajaranController controller;

  const MataPelajaranCreateDialog({Key? key, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<MataPelajaranCreateDialog> createState() => _MataPelajaranCreateDialogState();
}

class _MataPelajaranCreateDialogState extends State<MataPelajaranCreateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _namaMapelCon;
  Divisi? _divisiCon;

  @override
  void initState() {
    _namaMapelCon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah Mata Pelajaran',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputField(
                  label: 'Nama Mapel',
                  controller: _namaMapelCon,
                  inputType: TextInputType.text,
                  validator: (s) {
                    if (s == null || s.isEmpty) return 'Harus Diisi';
                    return null;
                  },
                ),
                FormDropdownSearch<Divisi>(
                  label: 'Divisi',
                  compareFn: (o1, o2) => o1?.id == o2?.id,
                  onFind: widget.controller.dialogOnFindDivisi,
                  showItem: (e) => '${e.id} - ${e.nama}',
                  onPick: (val) {
                    setState(() {
                      _divisiCon = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            MataPelajaran(0, _divisiCon!, _namaMapelCon.text),
          ),
        ),
      ],
    );
  }
}