
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/admin/admin_home_admin_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/test-repositories/admin_repo_impl.dart';
import 'package:rapor_lc/domain/entities/admin.dart';

class AdminHomeAdminUI extends View {
  AdminHomeAdminUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeAdminUIView();
}

class AdminHomeAdminUIView extends ViewState<AdminHomeAdminUI, AdminHomeAdminController> {
  AdminHomeAdminUIView()
      : super(AdminHomeAdminController(AdminRepositoryImplTest()));

  @override
  Widget get view => Center(
    child: Card(
      key: globalKey,
      child: ControlledWidgetBuilder<AdminHomeAdminController>(
        builder: (context, controller) {
          return CustomDataTable<Admin>(
            controller: controller,
            title: 'Admin',
            tableHeaders: const [
              'Email',
              'Name',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.email ?? '')),
              DataCell(Text(item.name)),
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