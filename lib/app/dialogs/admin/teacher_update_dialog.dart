
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_checkbox.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

class TeacherUpdateDialog extends StatefulWidget {
  final Teacher teacher;
  final Function(Teacher) onSave;
  final Future<List<Divisi>> Function(String?, bool) onFindDivisi;

  const TeacherUpdateDialog({Key? key, required this.teacher, required this.onSave, required this.onFindDivisi,
  }) : super(key: key);

  @override
  State<TeacherUpdateDialog> createState() => _TeacherUpdateDialogState();
}

class _TeacherUpdateDialogState extends State<TeacherUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _idCon;
  late final TextEditingController _nameCon;
  late final TextEditingController _emailCon;
  late final TextEditingController _passwordCon;
  bool _isLeaderCon = false;
  Divisi? _divisiCon;
  Divisi? _divisiBlockCon;

  @override
  void initState() {
    _idCon = TextEditingController(text: widget.teacher.id.toString());
    _nameCon = TextEditingController(text: widget.teacher.name);
    _emailCon = TextEditingController(text: widget.teacher.email);
    _passwordCon = TextEditingController(text: widget.teacher.password);
    _isLeaderCon = widget.teacher.isLeader ?? false;
    _divisiCon = widget.teacher.divisi;
    _divisiBlockCon = widget.teacher.divisiBlock;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah Teacher',
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
                  label: 'Name',
                  controller: _nameCon,
                ),
                FormInputField(
                  label: 'Email',
                  controller: _emailCon,
                ),
                FormInputField(
                  label: 'Password',
                  controller: _passwordCon,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: FormInputFieldCheckBox(
                    'Is Leader',
                    _isLeaderCon,
                        (val) {
                      setState(() {
                        _isLeaderCon = val;
                      });
                    },
                  ),
                ),
                FormDropdownSearch<Divisi>(
                  label: 'Divisi',
                  compareFn: (o1, o2) => o1 == o2,
                  onFind: (s) => widget.onFindDivisi(s, false),
                  showItem: (item) => '${item.id} - ${item.name}',
                  selectedItem: () => _divisiCon,
                  onPick: (item) {
                    setState(() {
                      _divisiCon = item;
                    });
                  },
                ),
                FormDropdownSearch<Divisi>(
                  label: 'Divisi Block',
                  compareFn: (o1, o2) => o1 == o2,
                  onFind: (s) => widget.onFindDivisi(s, true),
                  showItem: (item) => '${item.id} - ${item.name}',
                  selectedItem: () => _divisiBlockCon,
                  validator: (s) => null,
                  onPick: (item) {
                    setState(() {
                      _divisiBlockCon = item;
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
            Teacher(widget.teacher.id, _nameCon.text,
              email: _emailCon.text,
              password: _passwordCon.text,
              isLeader: _isLeaderCon,
              divisi: _divisiCon!,
              divisiBlock: _divisiBlockCon,
            ),
          ),
        ),
      ],
    );
  }
}