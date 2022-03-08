
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/santri/admin_home_santri_controller.dart';

class SantriUpdateDialog extends StatefulWidget {
  final Santri santri;
  final Function(Santri) onSave;
  final AdminHomeSantriController controller;

  const SantriUpdateDialog({Key? key, required this.santri,
    required this.onSave, required this.controller}) : super(key: key);

  @override
  State<SantriUpdateDialog> createState() => _SantriUpdateDialogState();
}

class _SantriUpdateDialogState extends State<SantriUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _nisCon;
  late final TextEditingController _nameCon;
  User? _teacherCon;

  @override
  void initState() {
    _nisCon = TextEditingController(text: widget.santri.nis);
    _nameCon = TextEditingController(text:  widget.santri.nama);
    _teacherCon = widget.santri.guru;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah Santri',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputField(
                  label: 'NIS',
                  controller: _nisCon,
                  isDisabled: true,
                ),
                FormInputField(
                  label: 'Nama',
                  controller: _nameCon,
                ),
                FormDropdownSearch<User>(
                  label: 'Guru',
                  compareFn: (o1, o2) => o1?.email.toLowerCase() == o2?.email.toLowerCase(),
                  onFind: widget.controller.dialogOnFindTeacher,
                  showItem: (e) => e.email,
                  onPick: (val) => _teacherCon = val,
                  selectedItem: () => _teacherCon,
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            Santri(_nisCon.text, _nameCon.text, guru: _teacherCon),
          ),
        ),
      ],
    );
  }
}