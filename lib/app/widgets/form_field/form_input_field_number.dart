
import 'package:flutter/material.dart';
import 'form_input_field.dart';

class FormInputFieldNumber extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const FormInputFieldNumber(this.label, this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormInputField(
      label: label,
      controller: controller,
      inputType: TextInputType.number,
      validator: (s) {
        if (s == null || s.isEmpty) return 'Harus diisi';
        return (double.tryParse(s) == null) ? 'Harus angka' : null;
      },
    );
  }
}