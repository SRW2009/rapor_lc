
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/npb.dart';

class NPBCreateDialog extends StatefulWidget {
  final int lastIndex;
  final Function(NPB) onSave;
  final Future<List<MataPelajaran>> Function(String?) onFindMapel;

  const NPBCreateDialog({Key? key,
    required this.lastIndex, required this.onSave, required this.onFindMapel,
  }) : super(key: key);

  @override
  State<NPBCreateDialog> createState() => _NPBCreateDialogState();
}

class _NPBCreateDialogState extends State<NPBCreateDialog> {
  final _key = GlobalKey<FormState>();
  MataPelajaran? _mapelCon;
  late final TextEditingController _nCon;

  @override
  void initState() {
    _nCon = TextEditingController();
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
                FormDropdownSearch<MataPelajaran>(
                  label: 'Mata Pelajaran',
                  compareFn: (o1, o2) => o1?.id == o2?.id,
                  onFind: widget.onFindMapel,
                  showItem: (e) => '${e.id} - ${e.name}',
                  onPick: (val) => _mapelCon = val,
                ),
                FormInputFieldNumberNullable('N', _nCon),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
              NPB(widget.lastIndex, _mapelCon!, (int.tryParse(_nCon.text) ?? -1))
          ),
        ),
      ],
    );
  }
}