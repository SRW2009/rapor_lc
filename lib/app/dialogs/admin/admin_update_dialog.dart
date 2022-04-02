
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/admin/admin_home_admin_controller.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';

class AdminUpdateDialog extends StatefulWidget {
  final Admin admin;
  final Function(Admin) onSave;
  final AdminHomeAdminController controller;

  const AdminUpdateDialog({Key? key, required this.admin, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<AdminUpdateDialog> createState() => _AdminUpdateDialogState();
}

class _AdminUpdateDialogState extends State<AdminUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _idCon;
  late final TextEditingController _nameCon;
  late final TextEditingController _emailCon;
  late final TextEditingController _passwordCon;

  @override
  void initState() {
    _idCon = TextEditingController(text: widget.admin.id.toString());
    _nameCon = TextEditingController(text: widget.admin.name);
    _emailCon = TextEditingController(text: widget.admin.email);
    _passwordCon = TextEditingController(text: widget.admin.password);
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
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            Admin(widget.admin.id, _nameCon.text,
              email: _emailCon.text,
              password: _passwordCon.text,
            ),
          ),
        ),
      ],
    );
  }
}