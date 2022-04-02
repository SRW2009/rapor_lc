
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/mapel/admin_home_mapel_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

class MataPelajaranUpdateDialog extends StatefulWidget {
  final MataPelajaran mataPelajaran;
  final Function(MataPelajaran) onSave;
  final AdminHomeMataPelajaranController controller;

  const MataPelajaranUpdateDialog({Key? key, required this.mataPelajaran, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<MataPelajaranUpdateDialog> createState() => _MataPelajaranUpdateDialogState();
}

class _MataPelajaranUpdateDialogState extends State<MataPelajaranUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _idCon;
  late final TextEditingController _nameCon;
  Divisi? _divisiCon;

  @override
  void initState() {
    _idCon = TextEditingController(text: widget.mataPelajaran.id.toString());
    _nameCon = TextEditingController(text: widget.mataPelajaran.name);
    _divisiCon = widget.mataPelajaran.divisi;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah Mata Pelajaran',
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
                FormInputField(
                  label: 'Nama Mapel',
                  controller: _nameCon,
                ),
                FormDropdownSearch<Divisi>(
                  label: 'Divisi',
                  compareFn: (o1, o2) => o1 == o2,
                  onFind: widget.controller.dialogOnFindDivisi,
                  showItem: (e) => '${e.id} - ${e.name}',
                  onPick: (val) {
                    setState(() {
                      _divisiCon = val;
                    });
                  },
                  selectedItem: () => _divisiCon,
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            MataPelajaran(widget.mataPelajaran.id, _nameCon.text,
              divisi: _divisiCon,
            ),
          ),
        ),
      ],
    );
  }
}