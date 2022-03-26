
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/divisi_repo_impl.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/divisi/admin_home_divisi_controller.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';

class AdminHomeDivisiUI extends View {
  AdminHomeDivisiUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeDivisiUIView();
}

class AdminHomeDivisiUIView extends ViewState<AdminHomeDivisiUI, AdminHomeDivisiController> {
  AdminHomeDivisiUIView()
      : super(AdminHomeDivisiController(DivisiRepositoryImpl()));

  @override
  Widget get view => Center(
    child: Card(
      key: globalKey,
      child: ControlledWidgetBuilder<AdminHomeDivisiController>(
        builder: (context, controller) {
          return CustomDataTable<Divisi>(
            controller: controller,
            title: 'Divisi',
            tableHeaders: const [
              'ID',
              'Nama',
              'Kadiv',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.id.toString())),
              DataCell(Text(item.nama)),
              DataCell(Text(item.kadiv)),
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