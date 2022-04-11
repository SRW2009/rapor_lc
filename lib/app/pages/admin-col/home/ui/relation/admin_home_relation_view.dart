
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/relation/admin_home_relation_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/test-repositories/relation_repo_impl.dart';
import 'package:rapor_lc/data/test-repositories/santri_repo_impl.dart';
import 'package:rapor_lc/data/test-repositories/teacher_repo_impl.dart';
import 'package:rapor_lc/domain/entities/relation.dart';

class AdminHomeRelationUI extends View {
  AdminHomeRelationUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeRelationUIView();
}

class AdminHomeRelationUIView extends ViewState<AdminHomeRelationUI, AdminHomeRelationController> {
  AdminHomeRelationUIView()
      : super(AdminHomeRelationController(RelationRepositoryImplTest(), TeacherRepositoryImplTest(), SantriRepositoryImplTest()));

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
              'Guru',
              'Santri',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.id.toString())),
              DataCell(Text(item.teacher.name)),
              DataCell(Text(item.santri.name)),
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