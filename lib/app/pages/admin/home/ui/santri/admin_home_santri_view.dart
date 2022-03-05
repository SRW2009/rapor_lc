
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/santri/admin_home_santri_controller.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/data/repositories/user_repo_impl.dart';
import 'package:rapor_lc/app/widgets/form_field/form_decoration.dart';

class AdminHomeSantriUI extends View {
  AdminHomeSantriUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeSantriUIView();
}

class AdminHomeSantriUIView extends ViewState<AdminHomeSantriUI, AdminHomeSantriController> {
  AdminHomeSantriUIView()
      : super(AdminHomeSantriController(SantriRepositoryImpl(), UserRepositoryImpl()));

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
                'Santri',
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              ControlledWidgetBuilder<AdminHomeSantriController>(
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
          child: ControlledWidgetBuilder<AdminHomeSantriController>(
            builder: (context, controller) {
              if (controller.santriState == RequestState.loaded) {
                final santriListLength = controller.filteredList.length;

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('NIS')),
                      DataColumn(label: Text('Nama')),
                      DataColumn(label: Text('Guru')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: List<DataRow>.generate(santriListLength, (index) {
                      final santri = controller.filteredList[index];
                      final selected = controller.selectedMap[santri.nis]!;

                      return DataRow(
                        selected: selected,
                        onSelectChanged: (val) =>
                            controller.tableOnSelectChanged(santri.nis, val!),
                        cells: [
                          DataCell(Text(santri.nis)),
                          DataCell(Text(santri.nama)),
                          DataCell(Text(santri.guru?.email ?? '')),
                          DataCell(IconButton(
                            onPressed: () => controller.tableOnEdit(santri),
                            icon: const Icon(Icons.edit),
                          )),
                        ],
                      );
                    }),
                  ),
                );
              }
              if (controller.santriState == RequestState.error) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Terjadi masalah.'),
                      const SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: controller.doGetSantriList,
                        child: const Text('Muat ulang'),
                      ),
                    ],
                  ),
                );
              }
              if (controller.santriState == RequestState.loading) {
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