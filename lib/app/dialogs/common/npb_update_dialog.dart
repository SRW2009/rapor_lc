
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/npb.dart';

class NPBUpdateDialog extends StatefulWidget {
  final NPB npb;
  final Function(NPB) onSave;
  final Future<List<MataPelajaran>> Function(String?) onFindMapel;

  const NPBUpdateDialog({Key? key,
    required this.npb, required this.onSave, required this.onFindMapel,
  }) : super(key: key);

  @override
  State<NPBUpdateDialog> createState() => _NPBUpdateDialogState();
}

class _NPBUpdateDialogState extends State<NPBUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _noCon;
  MataPelajaran? _mapelCon;
  late final TextEditingController _nCon;

  @override
  void initState() {
    _noCon = TextEditingController(text: widget.npb.no.toString());
    _mapelCon = widget.npb.pelajaran;
    _nCon = TextEditingController(text: widget.npb.n.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah NPB',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputField(
                  label: 'Nomor',
                  controller: _noCon,
                  isDisabled: true,
                ),
                FormDropdownSearch<MataPelajaran>(
                  label: 'Mata Pelajaran',
                  compareFn: (o1, o2) => o1?.id == o2?.id,
                  onFind: widget.onFindMapel,
                  showItem: (e) => '${e.id} - ${e.name}',
                  onPick: (val) => _mapelCon = val,
                  selectedItem: () => _mapelCon,
                ),
                FormInputFieldNumberNullable('N', _nCon),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
              NPB(widget.npb.no, _mapelCon!, (int.tryParse(_nCon.text) ?? -1))
          ),
        ),
      ],
    );
  }
}