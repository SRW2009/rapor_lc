
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

class MataPelajaranUpdateDialog extends StatefulWidget {
  final MataPelajaran mataPelajaran;
  final Function(MataPelajaran) onSave;
  final Future<List<Divisi>> Function(String?) onFindDivisi;

  const MataPelajaranUpdateDialog({Key? key, required this.mataPelajaran, required this.onSave, required this.onFindDivisi,
  }) : super(key: key);

  @override
  State<MataPelajaranUpdateDialog> createState() => _MataPelajaranUpdateDialogState();
}

class _MataPelajaranUpdateDialogState extends State<MataPelajaranUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _idCon;
  late final TextEditingController _nameCon;
  late final TextEditingController _abbrCon;
  Divisi? _divisiCon;

  @override
  void initState() {
    _idCon = TextEditingController(text: widget.mataPelajaran.id.toString());
    _nameCon = TextEditingController(text: widget.mataPelajaran.name);
    _abbrCon = TextEditingController(text: widget.mataPelajaran.abbreviation);
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
                FormInputField(
                  label: 'Singkatan Mapel',
                  controller: _abbrCon,
                  validator: (s) => null,
                ),
                FormDropdownSearch<Divisi>(
                  label: 'Divisi',
                  compareFn: (o1, o2) => o1 == o2,
                  onFind: widget.onFindDivisi,
                  showItem: (e) => '${e.id} - ${e.name} ${e.isBlock?'(Block System)':''}',
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
            MataPelajaran(widget.mataPelajaran.id,
              _nameCon.text,
              divisi: _divisiCon!,
              abbreviation: _abbrCon.text.isEmpty ? null : _abbrCon.text,
            ),
          ),
        ),
      ],
    );
  }
}