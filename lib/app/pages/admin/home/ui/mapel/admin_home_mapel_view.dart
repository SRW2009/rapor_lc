
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/divisi_repo_impl.dart';
import 'package:rapor_lc/data/repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/mapel/admin_home_mapel_controller.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

class AdminHomeMataPelajaranUI extends View {
  AdminHomeMataPelajaranUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeMataPelajaranUIView();
}

class AdminHomeMataPelajaranUIView extends ViewState<AdminHomeMataPelajaranUI, AdminHomeMataPelajaranController> {
  AdminHomeMataPelajaranUIView()
      : super(AdminHomeMataPelajaranController(MataPelajaranRepositoryImpl(), DivisiRepositoryImpl()));

  @override
  Widget get view => Center(
    child: Card(
      key: globalKey,
      child: ControlledWidgetBuilder<AdminHomeMataPelajaranController>(
        builder: (context, controller) {
          return CustomDataTable<MataPelajaran>(
            controller: controller,
            title: 'Mata Pelajaran',
            tableHeaders: const [
              'ID',
              'Nama Mapel',
              'Nama Divisi',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.id.toString())),
              DataCell(Text(item.nama_mapel)),
              DataCell(Text(item.divisi.nama)),
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