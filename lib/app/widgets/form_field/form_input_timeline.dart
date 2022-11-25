
import 'package:flutter/material.dart';
import 'package:rapor_lc/domain/entities/timeline.dart';

class FormInputTimeline extends StatefulWidget {
  final Timeline timeline;
  final void Function(Timeline val) onChanged;
  final String? label;
  final bool inputBulan;

  const FormInputTimeline({Key? key,
    required this.timeline,
    required this.onChanged,
    this.label,
    this.inputBulan=true,
  }) : super(key: key);

  @override
  State<FormInputTimeline> createState() => _FormInputTimelineState();
}

class _FormInputTimelineState extends State<FormInputTimeline> {
  late bool isOdd;

  @override
  void initState() {
    isOdd = widget.timeline.semester.isOdd;
    if (!widget.inputBulan) widget.timeline..bulan=1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        children: [
          if (widget.label != null) Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(widget.label!, style: Theme.of(context).textTheme.bodyText1),
          ),
          FormField<Timeline>(
            initialValue: widget.timeline,
            validator: (val) {
              if (val == null ||
                  (val.bulan == 0 && val.semester == 0 && val.kelas == 0 && val.level == 0))
                return 'Pilih Bulan, Semester, Kelas dan Level. ';
              if (val.bulan == 0) return 'Pilih Bulan';
              if (val.semester == 0) return 'Pilih Semester';
              if (val.kelas == 0) return 'Pilih Kelas';
              if (val.level == 0) return 'Pilih Level';
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
                          value: widget.timeline.semester != 0 ? widget.timeline.semester : null,
                          items: Timeline.semesterRange.map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                            value: e,
                            child: Text('Semester ${NumberInRoman.values[e - 1].name}'),
                          )).toList(),
                          onChanged: (index) {
                            if (index != null) {
                              widget.onChanged(
                                  widget.timeline
                                    ..semester=index
                                    ..bulan=(widget.inputBulan) ? 0
                                        : (index==2) ? 7 : 1
                              );
                              setState(() {
                                isOdd = (index%2==1);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    if (widget.inputBulan) const SizedBox(width: 24.0),
                    if (widget.inputBulan) Expanded(
                      child: _container(
                        state: state,
                        child: DropdownButton<int>(
                          hint: const Text('Bulan'),
                          underline: const SizedBox(),
                          isExpanded: true,
                          value: widget.timeline.bulan != 0 ? widget.timeline.bulan : null,
                          items: Timeline.bulanRange.getRange(isOdd ? 0 : 6, isOdd ? 6 : 12)
                              .map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                            value: e,
                            child: Text(Bulan.values[e-1].name),
                          )).toList(),
                          onChanged: (index) {
                            if (index != null) {
                              widget.onChanged(widget.timeline..bulan=index);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: _container(
                          state: state,
                          child: DropdownButton<int>(
                            hint: const Text('Kelas'),
                            underline: const SizedBox(),
                            isExpanded: true,
                            value: widget.timeline.kelas != 0 ? widget.timeline.kelas : null,
                            items: Timeline.kelasRange.map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                              value: e,
                              child: Text('Kelas $e'),
                            )).toList(),
                            onChanged: (index) {
                              if (index != null) {
                                widget.onChanged(widget.timeline..kelas=index);
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
                            hint: const Text('Level'),
                            underline: const SizedBox(),
                            isExpanded: true,
                            value: widget.timeline.level != 0 ? widget.timeline.level : null,
                            items: Timeline.levelRange.map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                              value: e,
                              child: Text('Level $e'),
                            )).toList(),
                            onChanged: (index) {
                              if (index != null) {
                                widget.onChanged(widget.timeline..level=index);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.hasError) Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(state.errorText!, style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.red),),
                ),
              ],
            ),
          ),
        ],
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