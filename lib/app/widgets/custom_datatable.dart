
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/base_datatable_controller.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'form_field/form_decoration.dart';

class CustomDataTable<Entity> extends StatefulWidget {
  final DataTableController<Entity> controller;
  final String title;
  final List<String> tableHeaders;
  final List<DataCell> Function(Entity item) tableContentBuilder;

  const CustomDataTable({
    Key? key,
    required this.controller,
    required this.title,
    required this.tableHeaders,
    required this.tableContentBuilder,
  }) : super(key: key);

  @override
  _CustomDataTableState createState() => _CustomDataTableState<Entity>();
}

class _CustomDataTableState<Entity> extends State<CustomDataTable<Entity>> {
  final _dataTableKey = GlobalKey();
  bool _hasResized = false;
  double? _finalWidth;

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return SizedBox(
      width: _finalWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 22.0,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 200.0,
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
                ),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (controller.dataTableState == RequestState.loaded) {
                  if (!_hasResized) {
                    _hasResized = true;
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                      final box = _dataTableKey.currentContext?.findRenderObject() as RenderBox?;
                      if (box != null) {
                        setState(() {
                          _finalWidth = box.size.width;
                        });
                      }
                    });
                  }

                  final filteredListLength = controller.filteredList.length;
                  return InteractiveViewer(
                    constrained: false,
                    scaleEnabled: false,
                    child: DataTable(
                      key: _dataTableKey,
                      columns: widget.tableHeaders
                          .map<DataColumn>((e) => DataColumn(label: Text(e))).toList(),
                      rows: List<DataRow>.generate(filteredListLength, (index) {
                        final Entity item = controller.filteredList[index];
                        final selected = controller.selectedMap[controller.getSelectedKey(item)]!;

                        return DataRow(
                          selected: selected,
                          onSelectChanged: (val) =>
                              controller.tableOnSelectChanged(controller.getSelectedKey(item), val!),
                          cells: widget.tableContentBuilder(item),
                        );
                      }),
                    ),
                  );
                }
                if (controller.dataTableState == RequestState.error) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Terjadi masalah.'),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: controller.refresh,
                          child: const Text('Muat ulang'),
                        ),
                      ],
                    ),
                  );
                }
                if (controller.dataTableState == RequestState.loading) {
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
}