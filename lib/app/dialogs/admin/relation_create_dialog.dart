
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/relation/admin_home_relation_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_dropdown_search.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class RelationCreateDialog extends StatefulWidget {
  final Function(Relation) onSave;
  final AdminHomeRelationController controller;

  const RelationCreateDialog({Key? key, required this.onSave, required this.controller,
  }) : super(key: key);

  @override
  State<RelationCreateDialog> createState() => _RelationCreateDialogState();
}

class _RelationCreateDialogState extends State<RelationCreateDialog> {
  final _key = GlobalKey<FormState>();
  Santri? _santriCon;
  Teacher? _teacherCon;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah Relation',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            Relation(
              0,
              _teacherCon!,
              _santriCon!,
            ),
          ),
        ),
      ],
    );
  }
}