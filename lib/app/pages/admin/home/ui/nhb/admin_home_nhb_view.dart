
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/data/repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/repositories/nhb_repo_impl.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/app/widgets/form_field/form_decoration.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/nhb/admin_home_nhb_controller.dart';

class AdminHomeNHBUI extends View {
  AdminHomeNHBUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeNHBUIView();
}

class AdminHomeNHBUIView extends ViewState<AdminHomeNHBUI, AdminHomeNHBController> {
  AdminHomeNHBUIView()
      : super(AdminHomeNHBController(NHBRepositoryImpl(), SantriRepositoryImpl(), MataPelajaranRepositoryImpl()));

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
                'NHB',
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              ControlledWidgetBuilder<AdminHomeNHBController>(
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
          child: ControlledWidgetBuilder<AdminHomeNHBController>(
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
                          DataColumn(label: Text('Nama Mapel')),
                          DataColumn(label: Text('Nilai Harian')),
                          DataColumn(label: Text('Nilai Bulanan')),
                          DataColumn(label: Text('Nilai Projek')),
                          DataColumn(label: Text('Nilai Akhir')),
                          DataColumn(label: Text('Akumulasi')),
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
                              DataCell(Text(item.mataPelajaran.namaMapel)),
                              DataCell(Text(item.nilaiHarian.toString())),
                              DataCell(Text(item.nilaiBulanan.toString())),
                              DataCell(Text(item.nilaiProject.toString())),
                              DataCell(Text(item.nilaiAkhir.toString())),
                              DataCell(Text(item.akumulasi.toString())),
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
                        onPressed: controller.doGetNHBList,
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