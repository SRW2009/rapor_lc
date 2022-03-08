
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/nk_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/app/widgets/form_field/form_decoration.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nk/admin_home_nk_controller.dart';
import 'package:rapor_lc/domain/entities/nk.dart';

class AdminHomeNKUI extends View {
  AdminHomeNKUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeNKUIView();
}

class AdminHomeNKUIView extends ViewState<AdminHomeNKUI, AdminHomeNKController> {
  AdminHomeNKUIView()
      : super(AdminHomeNKController(NKRepositoryImpl(), SantriRepositoryImpl()));

  @override
  Widget get view => Center(
    child: Card(
      key: globalKey,
      child: ControlledWidgetBuilder<AdminHomeNKController>(
        builder: (context, controller) => CustomDataTable<NK>(
            controller: controller,
            title: 'NK',
            tableHeaders: const [
              'ID',
              'Nama Santri',
              'Semester',
              'Tahun Ajaran',
              'Bulan ke-n',
              'Nama Variabel',
              'Nilai Mesjid',
              'Nilai Kelas',
              'Nilai Asrama',
              'Akumulatif',
              'Predikat',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.id.toString())),
              DataCell(Text(item.santri.nama)),
              DataCell(Text(item.semester.toString())),
              DataCell(Text(item.tahunAjaran)),
              DataCell(Text(item.bulan.toString())),
              DataCell(Text(item.variable)),
              DataCell(Text(item.nilaiMesjid.toString())),
              DataCell(Text(item.nilaiKelas.toString())),
              DataCell(Text(item.nilaiAsrama.toString())),
              DataCell(Text(item.akumulatif.toString())),
              DataCell(Text(item.predikat)),
              DataCell(IconButton(
                onPressed: () => controller.tableOnEdit(item),
                icon: const Icon(Icons.edit),
              )),
            ],
          )
      ),
    ),
  );
}