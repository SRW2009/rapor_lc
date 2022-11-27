
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/admin/admin_home_admin_controller.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';

class AdminCreateDialog extends StatefulWidget {
  final Function(Admin) onSave;
  final AdminHomeAdminController controller;

  const AdminCreateDialog({Key? key, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<AdminCreateDialog> createState() => _AdminCreateDialogState();
}

class _AdminCreateDialogState extends State<AdminCreateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _nameCon;
  late final TextEditingController _emailCon;
  late final TextEditingController _passwordCon;

  @override
  void initState() {
    _nameCon = TextEditingController();
    _emailCon = TextEditingController();
    _passwordCon = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah Admin',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            Admin(0, _nameCon.text,
              email: _emailCon.text,
              password: _passwordCon.text,
            ),
          ),
        ),
      ],
    );
  }
}