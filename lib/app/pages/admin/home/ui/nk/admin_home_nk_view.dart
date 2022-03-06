
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/data/repositories/nk_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/app/widgets/form_field/form_decoration.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nk/admin_home_nk_controller.dart';

class AdminHomeNKUI extends View {
  AdminHomeNKUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeNKUIView();
}

class AdminHomeNKUIView extends ViewState<AdminHomeNKUI, AdminHomeNKController> {
  AdminHomeNKUIView()
      : super(AdminHomeNKController(NKRepositoryImpl(), SantriRepositoryImpl()));

  @override
  Widget get view => Card(
    key: globalKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'NK',
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              ControlledWidgetBuilder<AdminHomeNKController>(
                builder: (context, controller) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 10.0),
                        width: 220.0,
                        child: TextField(
                          decoration: inputDecoration
                              .copyWith(
                            hintText: 'Search...',
                            prefixIcon: const Icon(Icons.search),
                          ),
                          onSubmitted: controller.tableSearch,
                        ),
                      ),
                      IconButton(
                        onPressed: controller.tableOnAdd,
                        icon: const Icon(Icons.add),
                      ),
                      IconButton(
                        onPressed: controller.selectedMap.values.any((element) => element)
                            ? controller.tableOnDelete : null,
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  );
                }
              ),
            ],
          ),
        ),
        Expanded(
          child: ControlledWidgetBuilder<AdminHomeNKController>(
            builder: (context, controller) {
              if (controller.dataState == RequestState.loaded) {
                final listLength = controller.filteredList.length;

                return InteractiveViewer(
                  constrained: false,
                  scaleEnabled: false,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Nama Santri')),
                      DataColumn(label: Text('Semester')),
                      DataColumn(label: Text('Tahun Ajaran')),
                      DataColumn(label: Text('Bulan ke-n')),
                      DataColumn(label: Text('Nama Variabel')),
                      DataColumn(label: Text('Nilai Mesjid')),
                      DataColumn(label: Text('Nilai Kelas')),
                      DataColumn(label: Text('Nilai Asrama')),
                      DataColumn(label: Text('Akumulatif')),
                      DataColumn(label: Text('Predikat')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: List<DataRow>.generate(listLength, (index) {
                      final item = controller.filteredList[index];
                      final selected = controller.selectedMap[controller.getSelectedKey(item)]!;

                      return DataRow(
                        selected: selected,
                        onSelectChanged: (val) =>
                            controller.tableOnSelectChanged(controller.getSelectedKey(item), val!),
                        cells: [
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
                      );
                    }),
                  ),
                );
              }
              if (controller.dataState == RequestState.error) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Terjadi masalah.'),
                      const SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: controller.doGetNKList,
                        child: const Text('Muat ulang'),
                      ),
                    ],
                  ),
                );
              }
              if (controller.dataState == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return const Center(
                child: Text('Belum ada data di sini.'),
              );
            }
          ),
        ),
      ],
    ),
  );
}