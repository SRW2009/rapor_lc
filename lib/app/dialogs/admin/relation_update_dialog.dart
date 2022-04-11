
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/relation/admin_home_relation_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class RelationUpdateDialog extends StatefulWidget {
  final Relation relation;
  final Function(Relation) onSave;
  final AdminHomeRelationController controller;

  const RelationUpdateDialog({Key? key, required this.relation, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<RelationUpdateDialog> createState() => _RelationUpdateDialogState();
}

class _RelationUpdateDialogState extends State<RelationUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _idCon;
  Santri? _santriCon;
  Teacher? _teacherCon;
  
  @override
  void initState() {
    _idCon = TextEditingController(text: widget.relation.id.toString());
    _santriCon = widget.relation.santri;
    _teacherCon = widget.relation.teacher;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Ubah Relation',
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
                FormDropdownSearch<Teacher>(
                  label: 'Teacher',
                  compareFn: (o1, o2) => o1 == o2,
                  onFind: widget.controller.dialogOnFindTeacher,
                  showItem: (item) => '${item.id} - ${item.name}',
                  onPick: (item) {
                    setState(() {
                      _teacherCon = item;
                    });
                  },
                  selectedItem: () => _teacherCon,
                ),
                FormDropdownSearch<Santri>(
                  label: 'Santri',
                  compareFn: (o1, o2) => o1 == o2,
                  onFind: widget.controller.dialogOnFindSantri,
                  showItem: (item) => '${item.id} - ${item.name}',
                  onPick: (item) {
                    setState(() {
                      _santriCon = item;
                    });
                  },
                  selectedItem: () => _santriCon,
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            Relation(
              widget.relation.id,
              _teacherCon!,
              _santriCon!,
            ),
          ),
        ),
      ],
    );
  }
}