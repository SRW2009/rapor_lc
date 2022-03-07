
import 'package:flutter/material.dart';
import 'form_decoration.dart';


class FormInputField extends StatefulWidget {
  const FormInputField({Key? key,
    this.controller, required this.label,
    this.icon, this.onTap, this.validator, this.maxLength,
    this.isPassword=false, this.isObscured=false, this.isDisabled=false, this.textColor=Colors.black,
    this.fillColor=Colors.white, this.iconColor=Colors.black, this.inputType=TextInputType.text,
    this.hint='', this.withoutPadding=false, this.maxLines=1,
  }) : super(key: key);

  final TextInputType inputType;
  final TextEditingController? controller;
  final String label;
  final IconData? icon;
  final bool isObscured, isPassword, isDisabled, withoutPadding;
  final Function()? onTap;
  final Color textColor;
  final Color fillColor;
  final Color iconColor;
  final String? Function(String?)? validator;
  final String hint;
  final int? maxLength;
  final int maxLines;

  @override
  FormInputFieldState createState() => FormInputFieldState();
}

class FormInputFieldState extends State<FormInputField> {
  String? Function(String?)? _validator;

  @override
  void initState() {
    super.initState();
    _validator = (s) {
      if (widget.validator != null) return widget.validator!(s);

      if (s == null || s.isEmpty) return 'Harus diisi';
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: (widget.withoutPadding) ? 0.0 : 24.0),
      child: TextFormField(
        enabled: !widget.isDisabled,
        keyboardType: widget.inputType,
        controller: (widget.controller != null) ? widget.controller : null,
        validator: _validator,
        obscureText: widget.isObscured,
        maxLength: widget.maxLength,
        style: TextStyle(
          color: widget.textColor,
        ),
        decoration: inputDecoration.copyWith(
          hintText: widget.hint,
          prefixIcon: (widget.icon != null) ? Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 10.0),
            child: Icon(
              widget.icon,
              color: widget.iconColor,
            ),
          ) : null,
          suffixIcon: widget.isPassword
              ? Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              child: Icon(
                widget.isObscured
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black,
              ),
              onTap: widget.onTap,
            ),
          )
              : null,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 24,
            minHeight: 24,
          ),
          fillColor:
          (widget.isDisabled)
              ? Colors.grey.shade200
              : widget.fillColor,
          labelText: widget.label,
        ),
        maxLines: widget.maxLines,
      ),
    );
  }
}