
import 'package:flutter/material.dart';


class FormInputFieldCheckBox extends StatelessWidget {
  final String label;
  final bool value;
  final void Function(bool i)? setState;

  const FormInputFieldCheckBox(this.label, this.value, this.setState, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Text(label, style: Theme.of(context).textTheme.bodyText1,),
        ),
        FormField<bool>(
          initialValue: value,
          builder: (state) {
            return Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: value,
                      onChanged: (setState == null) ? null : (val) {
                        if (val != null) {
                          state.setValue(val);
                          setState!(val);
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(value ? 'Ya' : 'Tidak', style: Theme.of(context).textTheme.caption,),
                    ),
                  ],
                ),
                if (state.hasError) Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(state.errorText!, style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.red),),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}