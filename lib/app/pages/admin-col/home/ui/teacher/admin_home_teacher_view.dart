
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/teacher/admin_home_teacher_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/divisi_repo_impl.dart';
import 'package:rapor_lc/data/repositories/teacher_repo_impl.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

class AdminHomeTeacherUI extends View {
  AdminHomeTeacherUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeTeacherUIView();
}

class AdminHomeTeacherUIView extends ViewState<AdminHomeTeacherUI, AdminHomeTeacherController> {
  AdminHomeTeacherUIView()
      : super(AdminHomeTeacherController(TeacherRepositoryImpl(), DivisiRepositoryImpl()));

  @override
  Widget get view => Center(
    child: Card(
      key: globalKey,
      child: ControlledWidgetBuilder<AdminHomeTeacherController>(
        builder: (context, controller) {
          return CustomDataTable<Teacher>(
            controller: controller,
            title: 'Teacher',
            tableHeaders: const [
              'Email',
              'Name',
              'Divisi',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.email ?? '')),
              DataCell(Text(item.name)),
              DataCell(Text(item.divisi?.name ?? '')),
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