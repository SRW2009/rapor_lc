
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/npb/admin_home_npb_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/repositories/npb_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';

class AdminHomeNPBUI extends View {
  AdminHomeNPBUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeNPBUIView();
}

class AdminHomeNPBUIView extends ViewState<AdminHomeNPBUI, AdminHomeNPBController> {
  AdminHomeNPBUIView()
      : super(AdminHomeNPBController(NPBRepositoryImpl(), SantriRepositoryImpl(), MataPelajaranRepositoryImpl()));

  @override
  Widget get view => Center(
    child: Card(
      key: globalKey,
      child: ControlledWidgetBuilder<AdminHomeNPBController>(
        builder: (context, controller) {
          return CustomDataTable<NPB>(
            controller: controller, 
            title: 'NPB', 
            tableHeaders: const [
              'ID',
              'Nama Santri',
              'Semester',
              'Tahun Ajaran',
              'Nama Mapel',
              'Presensi',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.id.toString())),
              DataCell(Text(item.santri.nama)),
              DataCell(Text(item.semester.toString())),
              DataCell(Text(item.tahun_ajaran)),
              DataCell(Text(item.pelajaran.nama_mapel)),
              DataCell(Text(item.presensi)),
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