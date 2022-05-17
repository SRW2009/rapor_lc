
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/nilai/admin_home_nilai_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';

class AdminHomeNilaiUI extends View {
  AdminHomeNilaiUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeNilaiUIView();
}

class AdminHomeNilaiUIView extends ViewState<AdminHomeNilaiUI, AdminHomeNilaiController> {
  AdminHomeNilaiUIView()
      : super(AdminHomeNilaiController(NilaiRepositoryImpl(), SantriRepositoryImpl()));

  @override
  Widget get view => Center(
    child: Card(
      key: globalKey,
      child: ControlledWidgetBuilder<AdminHomeNilaiController>(
        builder: (context, controller) {
          return CustomDataTable<Nilai>(
            controller: controller,
            title: 'Nilai',
            tableHeaders: const [
              'ID',
              'Bulan',
              'Tahun Ajaran',
              'Santri',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.id.toString())),
              DataCell(Text(item.BaS.toReadableString())),
              DataCell(Text(item.tahunAjaran)),
              DataCell(Text(item.santri.name)),
              DataCell(Row(
                children: [
                  IconButton(
                    onPressed: () => controller.tableOnEdit(item),
                    icon: const Icon(Icons.edit),
                  ),
                  PopupMenuButton<Type>(
                    padding: EdgeInsets.zero,
                    onSelected: (arg) => controller.tableOnMore(item, arg),
                    itemBuilder: (context) => <PopupMenuItem<Type>>[
                      const PopupMenuItem(
                        value: NHB,
                        child: Text('NHB'),
                      ),
                      const PopupMenuItem(
                        value: NK,
                        child: Text('NK'),
                      ),
                      const PopupMenuItem(
                        value: NPB,
                        child: Text('NPB'),
                      ),
                    ],
                  ),
                ],
              )),
            ],
          );
        }
      ),
    ),
  );
}