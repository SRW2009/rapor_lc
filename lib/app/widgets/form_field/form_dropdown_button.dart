
import 'package:flutter/material.dart';

class FormDropdownButton<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final void Function(T i) setState;
  final String errorMsg;

  const FormDropdownButton({Key? key, required this.label, required this.items,
    this.value, required this.setState, required this.errorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: FormField<T>(
        initialValue: value,
        validator: (val) => (val == null) ? errorMsg : null,
        builder: (state) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: (state.hasError)
                  ? Colors.red.withOpacity(.50)
                  : Colors.grey.withOpacity(.20),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: DropdownButton<T>(
            hint: Text(label),
            underline: const SizedBox(),
            isExpanded: true,
            value: value,
            items: items,
            onChanged: (val) {
              if (val != null) {
                state.setValue(val);
                setState(val);
              }
            },
          ),
        ),
      ),
    );
  }
}
