
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/repositories/nhb_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nhb/admin_home_nhb_controller.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';

class AdminHomeNHBUI extends View {
  AdminHomeNHBUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeNHBUIView();
}

class AdminHomeNHBUIView extends ViewState<AdminHomeNHBUI, AdminHomeNHBController> {
  AdminHomeNHBUIView()
      : super(AdminHomeNHBController(NHBRepositoryImpl(), SantriRepositoryImpl(), MataPelajaranRepositoryImpl()));

  @override
  Widget get view => Center(
    child: Card(
      key: globalKey,
      child: ControlledWidgetBuilder<AdminHomeNHBController>(
        builder: (context, controller) => CustomDataTable<NHB>(
          controller: controller,
          title: 'NHB',
          tableHeaders: const [
            'ID',
            'Nama Santri',
            'Semester',
            'Tahun Ajaran',
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
            DataCell(Text(item.id.toString())),
            DataCell(Text(item.santri.nama)),
            DataCell(Text(item.semester.toString())),
            DataCell(Text(item.tahun_ajaran)),
            DataCell(Text(item.pelajaran.nama_mapel)),
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
  );
}