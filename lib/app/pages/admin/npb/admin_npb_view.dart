
// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/npb/admin_npb_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/test-repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/test-repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class AdminNPBPage extends View {
  AdminNPBPage({Key? key, required this.nilai}) : super(key: key);

  final Nilai nilai;

  @override
  AdminNPBPageView createState() => AdminNPBPageView(nilai);
}

class AdminNPBPageView extends ViewState<AdminNPBPage, AdminNPBController> {
  AdminNPBPageView(nilai)
      : super(AdminNPBController(NilaiRepositoryImplTest(), MataPelajaranRepositoryImplTest(), nilai));

  @override
  Widget get view => Scaffold(
    key: globalKey,
    appBar: AppBar(
      title: Text(widget.nilai.santri.name),
    ),
    body: Center(
      child: Card(
        child: ControlledWidgetBuilder<AdminNPBController>(
          builder: (context, controller) => CustomDataTable<NPB>(
            controller: controller,
            title: 'NPB',
            tableHeaders: const [
              'No',
              'Nama Mapel',
              'Presensi',
              '/n',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.no.toString())),
              DataCell(Text(item.pelajaran.name)),
              DataCell(Text(item.presensi)),
              DataCell(Text(item.n.toString())),
              DataCell(IconButton(
                onPressed: () => controller.tableOnEdit(item),
                icon: const Icon(Icons.edit),
              )),
            ],
          ),
        ),
      ),
    ),
  );
}