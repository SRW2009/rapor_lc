
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

class MataPelajaranCreateDialog extends StatefulWidget {
  final Function(MataPelajaran) onSave;
  final Future<List<Divisi>> Function(String?) onFindDivisi;

  const MataPelajaranCreateDialog({Key? key, required this.onSave, required this.onFindDivisi,
  }) : super(key: key);

  @override
  State<MataPelajaranCreateDialog> createState() => _MataPelajaranCreateDialogState();
}

class _MataPelajaranCreateDialogState extends State<MataPelajaranCreateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _nameCon;
  late final TextEditingController _abbrCon;
  Divisi? _divisiCon;

  @override
  void initState() {
    _nameCon = TextEditingController();
    _abbrCon = TextEditingController();
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
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            MataPelajaran(0, _nameCon.text,
              divisi: _divisiCon!,
              abbreviation: _abbrCon.text.isEmpty ? null : _abbrCon.text,
            ),
          ),
        ),
      ],
    );
  }
}