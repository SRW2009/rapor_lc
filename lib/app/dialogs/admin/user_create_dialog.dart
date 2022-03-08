
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/user/admin_home_user_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_radios.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';

class UserCreateDialog extends StatefulWidget {
  final Function(User) onSave;
  final AdminHomeUserController controller;

  const UserCreateDialog({Key? key, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<UserCreateDialog> createState() => _UserCreateDialogState();
}

class _UserCreateDialogState extends State<UserCreateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _emailCon;
  late final TextEditingController _passwordCon;
  int _statusCon = -1;

  @override
  void initState() {
    _emailCon = TextEditingController();
    _passwordCon = TextEditingController();
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
                ),
                FormInputField(
                  label: 'Password',
                  controller: _passwordCon,
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