
// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/nhb/admin_nhb_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/test-repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/test-repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class AdminNHBPage extends View {
  AdminNHBPage({Key? key, required this.nilai}) : super(key: key);

  final Nilai nilai;

  @override
  AdminNHBPageView createState() => AdminNHBPageView(nilai);
}

class AdminNHBPageView extends ViewState<AdminNHBPage, AdminNHBController> {
  AdminNHBPageView(nilai)
      : super(AdminNHBController(NilaiRepositoryImplTest(), MataPelajaranRepositoryImplTest(), nilai));

  @override
  Widget get view => Scaffold(
    key: globalKey,
    appBar: AppBar(
      title: Text(widget.nilai.santri.name),
    ),
    body: Center(
      child: Card(
        child: ControlledWidgetBuilder<AdminNHBController>(
          builder: (context, controller) => CustomDataTable<NHB>(
            controller: controller,
            title: 'NHB',
            tableHeaders: const [
              'No',
              'Nama Mapel',
              'Nilai Harian',
              'Nilai Bulanan',
              'Nilai Projek',
              'Nilai Akhir',
              'Akumulasi',
              'Predikat',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.no.toString())),
              DataCell(Text(item.pelajaran.name)),
              DataCell(Text(item.nilai_harian.toString())),
              DataCell(Text(item.nilai_bulanan.toString())),
              DataCell(Text(item.nilai_projek.toString())),
              DataCell(Text(item.nilai_akhir.toString())),
              DataCell(Text(item.akumulasi.toString())),
              DataCell(Text(item.predikat)),
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