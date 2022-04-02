
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nilai/admin_home_nilai_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/domain/entities/bulan_and_semester.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class NilaiUpdateDialog extends StatefulWidget {
  final Nilai nilai;
  final Function(Nilai) onSave;
  final AdminHomeNilaiController controller;

  const NilaiUpdateDialog({Key? key, required this.nilai, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<NilaiUpdateDialog> createState() => _NilaiUpdateDialogState();
}

class _NilaiUpdateDialogState extends State<NilaiUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _idCon;
  late BulanAndSemester _BaSCon;
  late final TextEditingController _tahunAjaranCon;
  Santri? _santriCon;

  @override
  void initState() {
    _idCon = TextEditingController(text: widget.nilai.id.toString());
    _BaSCon = widget.nilai.BaS;
    _tahunAjaranCon = TextEditingController(text: widget.nilai.tahunAjaran);
    _santriCon = widget.nilai.santri;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah Nilai',
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: DropdownButton<int>(
                          hint: const Text('Bulan'),
                          isExpanded: true,
                          value: _BaSCon.bulan != 0 ? _BaSCon.bulan : null,
                          items: Month.values.map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                            value: e.index+1,
                            child: Text(e.name),
                          )).toList(),
                          onChanged: (index) {
                            if (index != null) {
                              setState(() {
                                _BaSCon.bulan = index;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 24.0),
                      Expanded(
                        child: DropdownButton<int>(
                          hint: const Text('Semester'),
                          isExpanded: true,
                          value: _BaSCon.semester != 0 ? _BaSCon.semester : null,
                          items: SemesterAsText.values.map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                            value: e.index+1,
                            child: Text(e.name),
                          )).toList(),
                          onChanged: (index) {
                            if (index != null) {
                              setState(() {
                                _BaSCon.semester = index;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                FormInputField(
                  label: 'Tahun Ajaran',
                  controller: _tahunAjaranCon,
                  hint: '2020/2021',
                  validator: (s) {
                    if (s == null || s.isEmpty) return 'Harus Diisi';
                    if (s.length != 9 || s.split('/').length != 2
                        || int.tryParse(s.substring(0,4)) == null
                        || int.tryParse(s.substring(5, 9)) == null) {
                      return 'Format Salah';
                    }
                    return null;
                  },
                ),
                FormDropdownSearch<Santri>(
                  label: 'Santri',
                  compareFn: (o1, o2) => o1 == o2,
                  onFind: widget.controller.dialogOnFindSantri,
                  showItem: (e) => '${e.nis} - ${e.name}',
                  onPick: (val) => _santriCon = val,
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            Nilai(widget.nilai.id, _BaSCon, _tahunAjaranCon.text, _santriCon!),
          ),
        ),
      ],
    );
  }
}