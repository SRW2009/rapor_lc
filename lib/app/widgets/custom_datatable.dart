
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/widgets/custom_datatable_controller.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'form_field/form_decoration.dart';

class CustomDataTable<Entity> extends StatefulWidget {
  final DataTableController<Entity> controller;
  final String title;
  final List<String> tableHeaders;
  final List<DataCell> Function(Entity item) tableContentBuilder;
  final bool showNumber;

  const CustomDataTable({
    Key? key,
    required this.controller,
    required this.title,
    required this.tableHeaders,
    required this.tableContentBuilder,
    this.showNumber=false,
  }) : super(key: key);

  @override
  _CustomDataTableState createState() => _CustomDataTableState<Entity>();
}

class _CustomDataTableState<Entity> extends State<CustomDataTable<Entity>> {
  static const _minWidth = 412.0;

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 4.0),
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
                    if (controller.createDialogExist) IconButton(
                      onPressed: controller.tableOnAdd,
                      icon: const Icon(Icons.add),
                    ),
                    if (controller.deleteDialogExist) IconButton(
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
                          _finalWidth = (box.size.width < _minWidth) ? _minWidth : box.size.width;
                        });
                      }
                    });
                  }

                  final filteredListLength = controller.filteredList.length;
                  return InteractiveViewer(
                    constrained: (_finalWidth ?? _minWidth) < _minWidth,
                    scaleEnabled: false,
                    child: DataTable(
                      key: _dataTableKey,
                      columns: [
                        if (widget.showNumber) const DataColumn(label: Text('No')),
                        ...widget.tableHeaders
                            .map<DataColumn>((e) => DataColumn(label: Text(e))).toList(),
                      ],
                      rows: List<DataRow>.generate(filteredListLength, (index) {
                        final Entity item = controller.filteredList[index];
                        final selected = controller.selectedMap[controller.getSelectedKey(item)]!;

                        return DataRow(
                          selected: selected,
                          onSelectChanged: (val) =>
                              controller.tableOnSelectChanged(controller.getSelectedKey(item), val!),
                          cells: [
                            if (widget.showNumber) DataCell(Text('$index')),
                            ...widget.tableContentBuilder(item),
                          ],
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
                  _hasResized = false;
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
