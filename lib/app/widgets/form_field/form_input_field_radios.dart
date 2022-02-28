
import 'package:flutter/material.dart';


class FormInputFieldRadios extends StatelessWidget {
  final String label;
  final int value;
  final void Function(int i) setState;
  final List<String> contents;

  const FormInputFieldRadios({required this.label, required this.value, required this.setState, required this.contents, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      initialValue: value,
      validator: (i) {
        if (i == null || i == -1) return 'Pilih salah satu';
        return null;
      },
      builder: (state) {
        return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodyText2,),
                const SizedBox(width: 12.0),
                for (var i = 0; i < contents.length; ++i)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio<int>(
                          value: i,
                          groupValue: value,
                          onChanged: (i) {
                            if (i != null) {
                              state.setValue(i);
                              setState(i);
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(contents[i], style: Theme.of(context).textTheme.caption,),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (state.hasError) Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(state.errorText!, style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.red),),
            ),
            const SizedBox(height: 16.0,),
          ],
        );
      },
    );
  }
}