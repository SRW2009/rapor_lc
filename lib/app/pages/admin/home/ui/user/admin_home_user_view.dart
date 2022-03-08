
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/user/admin_home_user_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/user_repo_impl.dart';
import 'package:rapor_lc/domain/entities/user.dart';

class AdminHomeUserUI extends View {
  AdminHomeUserUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeUserUIView();
}

class AdminHomeUserUIView extends ViewState<AdminHomeUserUI, AdminHomeUserController> {
  AdminHomeUserUIView()
      : super(AdminHomeUserController(UserRepositoryImpl()));

  @override
  Widget get view => Center(
    child: Card(
      key: globalKey,
      child: ControlledWidgetBuilder<AdminHomeUserController>(
        builder: (context, controller) {
          return CustomDataTable<User>(
            controller: controller,
            title: 'User',
            tableHeaders: const [
              'Email',
              'Privilege',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.email.toString())),
              DataCell(Text(item.getStatusName)),
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