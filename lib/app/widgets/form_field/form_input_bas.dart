
import 'package:flutter/material.dart';
import 'package:rapor_lc/domain/entities/bulan_and_semester.dart';

class FormInputBaS extends StatefulWidget {
  final BulanAndSemester BaS;
  final void Function(BulanAndSemester val) onChanged;

  const FormInputBaS({Key? key,
    required this.BaS,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FormInputBaS> createState() => _FormInputBaSState();
}

class _FormInputBaSState extends State<FormInputBaS> {
  bool isOdd = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: FormField<BulanAndSemester>(
        initialValue: widget.BaS,
        validator: (val) {
          if (val == null || (val.bulan == 0 && val.semester == 0)) return 'Pilih Bulan & Semester';
          if (val.bulan == 0) return 'Pilih Bulan';
          if (val.semester == 0) return 'Pilih Semester';
          return null;
        },
        builder: (state) => Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: _container(
                    state: state,
                    child: DropdownButton<int>(
                      hint: const Text('Semester'),
                      underline: const SizedBox(),
                      isExpanded: true,
                      value: widget.BaS.semester != 0 ? widget.BaS.semester : null,
                      items: SemesterAsText.values.map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                        value: e.index+1,
                        child: Text(e.name),
                      )).toList(),
                      onChanged: (index) {
                        if (index != null) {
                          widget.onChanged(widget.BaS..semester=index..bulan=0);
                          setState(() {
                            isOdd = (index%2==1);
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 24.0),
                Expanded(
                  child: _container(
                    state: state,
                    child: DropdownButton<int>(
                      hint: const Text('Bulan'),
                      underline: const SizedBox(),
                      isExpanded: true,
                      value: widget.BaS.bulan != 0 ? widget.BaS.bulan : null,
                      items: Month.values
                          .getRange(isOdd ? 0 : 6, isOdd ? 6 : 12)
                          .map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                        value: e.index+1,
                        child: Text(e.name),
                      )).toList(),
                      onChanged: (index) {
                        if (index != null) {
                          widget.onChanged(widget.BaS..bulan=index);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (state.hasError) Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(state.errorText!, style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.red),),
            ),
          ],
        ),
      ),
    );
  }

  Container _container({required FormFieldState state, required Widget child}) {
    return Container(
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
      child: child,
    );
  }
}