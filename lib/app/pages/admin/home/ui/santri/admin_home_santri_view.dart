
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/santri/admin_home_santri_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/data/repositories/user_repo_impl.dart';
import 'package:rapor_lc/app/widgets/form_field/form_decoration.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class AdminHomeSantriUI extends View {
  AdminHomeSantriUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeSantriUIView();
}

class AdminHomeSantriUIView extends ViewState<AdminHomeSantriUI, AdminHomeSantriController> {
  AdminHomeSantriUIView()
      : super(AdminHomeSantriController(SantriRepositoryImpl(), UserRepositoryImpl()));

  @override
  Widget get view => Center(
      child: Card(
        key: globalKey,
        child: ControlledWidgetBuilder<AdminHomeSantriController>(
          builder: (context, controller) => CustomDataTable<Santri>(
            controller: controller,
            title: 'Santri',
            tableHeaders: const [
              'NIS', 'Nama',
              'Guru', 'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.nis)),
              DataCell(Text(item.nama)),
              DataCell(Text(item.guru?.email ?? '')),
              DataCell(IconButton(
                onPressed: () => controller.tableOnEdit(item),
                icon: const Icon(Icons.edit),
              )),
            ],
          ),
        ),
      ),
    );
}