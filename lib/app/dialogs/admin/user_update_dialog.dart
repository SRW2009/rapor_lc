
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/user/admin_home_user_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_radios.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';

class UserUpdateDialog extends StatefulWidget {
  final User user;
  final Function(User) onSave;
  final AdminHomeUserController controller;

  const UserUpdateDialog({Key? key, required this.user, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<UserUpdateDialog> createState() => _UserUpdateDialogState();
}

class _UserUpdateDialogState extends State<UserUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _emailCon;
  late final TextEditingController _passwordCon;
  int _statusCon = -1;

  @override
  void initState() {
    _emailCon = TextEditingController(text: widget.user.email);
    _passwordCon = TextEditingController(text: widget.user.password);
    _statusCon = (widget.user.status-1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah User',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputField(
                  label: 'Email',
                  controller: _emailCon,
                  inputType: TextInputType.text,
                  validator: (s) {
                    if (s == null || s.isEmpty) return 'Harus Diisi';
                    return null;
                  },
                ),
                FormInputField(
                  label: 'Password',
                  controller: _passwordCon,
                  inputType: TextInputType.text,
                  validator: (s) {
                    if (s == null || s.isEmpty) return 'Harus Diisi';
                    return null;
                  },
                ),
                FormInputFieldRadios(
                  label: 'Status',
                  value: _statusCon,
                  onChanged: (val) {
                    setState(() {
                      _statusCon = val;
                    });
                  },
                  contents: const ['Teacher', 'Admin'],
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            User(_emailCon.text, _passwordCon.text, status: (_statusCon+1)),
          ),
        ),
      ],
    );
  }
}