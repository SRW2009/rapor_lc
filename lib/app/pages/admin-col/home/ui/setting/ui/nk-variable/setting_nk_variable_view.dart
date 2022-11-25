
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/ui/nk-variable/setting_nk_variable_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/divisi_repo_impl.dart';
import 'package:rapor_lc/data/repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';

class SettingNKVariableUI extends View {
  final Function() refreshSettingFunc;

  SettingNKVariableUI({Key? key, required this.refreshSettingFunc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingNKVariableUIView(refreshSettingFunc);
}

class SettingNKVariableUIView extends ViewState<SettingNKVariableUI, SettingNKVariableController> {
  SettingNKVariableUIView(refreshSettingFunc)
      : super(SettingNKVariableController(refreshSettingFunc, MataPelajaranRepositoryImpl(), DivisiRepositoryImpl()));

  @override
  Widget get view => Card(
    key: globalKey,
    child: ControlledWidgetBuilder<SettingNKVariableController>(
      builder: (context, controller) {
        return CustomDataTable<MataPelajaran>(
          controller: controller,
          title: 'Variabel NK',
          tableHeaders: const [
            'ID',
            'Nama Variabel',
            'Action',
          ],
          tableContentBuilder: (item) => [
            DataCell(Text(item.id.toString())),
            DataCell(Text(item.name)),
            DataCell(IconButton(
              onPressed: () => controller.tableOnEdit(item),
              icon: const Icon(Icons.edit),
            )),
          ],
        );
      }
    ),
  );
}