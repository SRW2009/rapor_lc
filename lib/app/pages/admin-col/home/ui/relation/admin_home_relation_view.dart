
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/relation/admin_home_relation_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/relation_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/data/repositories/teacher_repo_impl.dart';
import 'package:rapor_lc/domain/entities/relation.dart';

class AdminHomeRelationUI extends View {
  AdminHomeRelationUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeRelationUIView();
}

class AdminHomeRelationUIView extends ViewState<AdminHomeRelationUI, AdminHomeRelationController> {
  AdminHomeRelationUIView()
      : super(AdminHomeRelationController(RelationRepositoryImpl(), TeacherRepositoryImpl(), SantriRepositoryImpl()));

  @override
  Widget get view => Center(
    child: Card(
      key: globalKey,
      child: ControlledWidgetBuilder<AdminHomeRelationController>(
        builder: (context, controller) {
          return CustomDataTable<Relation>(
            controller: controller,
            title: 'Relation',
            tableHeaders: const [
              'ID',
              'Nama',
              'Guru',
              'Santri',
              'Status',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.id.toString())),
              DataCell(Text(item.name ?? '')),
              DataCell(Text(item.teacher.name)),
              DataCell(Text(item.santri.name)),
              DataCell(Row(
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: item.isActive ? Colors.green : Colors.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(item.isActive ? 'Aktif' : 'Nonaktif'),
                  ),
                ],
              )),
              DataCell(IconButton(
                onPressed: () => controller.tableOnEdit(item),
                icon: const Icon(Icons.edit),
              )),
            ],
          );
        }
      ),
    ),
  );
}