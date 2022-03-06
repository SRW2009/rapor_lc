
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/data/repositories/user_repo_impl.dart';
import 'package:rapor_lc/app/widgets/form_field/form_decoration.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/user/admin_home_user_controller.dart';

class AdminHomeUserUI extends View {
  AdminHomeUserUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeUserUIView();
}

class AdminHomeUserUIView extends ViewState<AdminHomeUserUI, AdminHomeUserController> {
  AdminHomeUserUIView()
      : super(AdminHomeUserController(UserRepositoryImpl()));

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
                'User',
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              ControlledWidgetBuilder<AdminHomeUserController>(
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
          child: ControlledWidgetBuilder<AdminHomeUserController>(
            builder: (context, controller) {
              if (controller.dataState == RequestState.loaded) {
                final listLength = controller.filteredList.length;

                return InteractiveViewer(
                  constrained: false,
                  scaleEnabled: false,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Privilege')),
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
                          DataCell(Text(item.email.toString())),
                          DataCell(Text(item.getStatusName)),
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
                        onPressed: controller.doGetUserList,
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