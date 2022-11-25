
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/subclasses/custom_datatable_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_decoration.dart';
import 'package:rapor_lc/app/widgets/my_paginated_data_table.dart';
import 'package:rapor_lc/common/enum/request_state.dart';

class CustomDataTable<Entity> extends StatefulWidget {
  final DataTableController<Entity> controller;
  final String title;
  final List<String> tableHeaders;
  final List<DataCell> Function(Entity item) tableContentBuilder;
  final bool showNumber;
  final bool selectable;
  final double afterResizeOverflowWidth;

  const CustomDataTable({
    Key? key,
    required this.controller,
    required this.title,
    required this.tableHeaders,
    required this.tableContentBuilder,
    this.showNumber=false,
    this.selectable=true,
    this.afterResizeOverflowWidth=0,
  }) : super(key: key);

  @override
  _CustomDataTableState createState() => _CustomDataTableState<Entity>();
}

class _CustomDataTableState<Entity> extends State<CustomDataTable<Entity>> {
  static const _minWidth = 412.0;

  late final _TableSource<Entity> source;
  final _dataTableKey = GlobalKey<PaginatedDataTableState>();
  final ScrollController scrollController = ScrollController();
  bool _hasResized = false;
  double? _finalWidth;

  @override
  void initState() {
    super.initState();
    source = _TableSource<Entity>(widget.controller, widget.tableContentBuilder, widget.selectable);
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    doResize();
  }

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
                    doResize();
                  }

                  return InteractiveViewer(
                    constrained: (_finalWidth ?? _minWidth) < _minWidth,
                    scaleEnabled: false,
                    child: MyPaginatedDataTable(
                      key: _dataTableKey,
                      columns: [
                        if (widget.showNumber) const DataColumn(label: Text('No')),
                        ...widget.tableHeaders
                            .map<DataColumn>((e) => DataColumn(label: Text(e))).toList(),
                      ],
                      source: _TableSource<Entity>(controller, widget.tableContentBuilder, widget.selectable)
                        ..addListener(() => doResize()),
                      columnSpacing: 50,
                      horizontalMargin: 30,
                      onPageChanged: (value) {
                        doResize();
                      },
                    ),
                  );
                }
                if (controller.dataTableState == RequestState.error) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(controller.errorMessage),
                        const SizedBox(height: 8.0),
                        if (controller.showReloadButton) ElevatedButton(
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

                return Center(
                  child: Text(controller.noDataMessage),
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  void doResize() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final box = _dataTableKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        final width = (box.size.width < _minWidth) ? _minWidth : box.size.width;
        setState(() {
          _finalWidth = width + widget.afterResizeOverflowWidth;
        });
      }
    });
  }
}

class _TableSource<Entity> extends DataTableSource {
  final DataTableController controller;
  final List<DataCell> Function(Entity item) cellBuilder;
  final bool selectable;

  _TableSource(this.controller, this.cellBuilder, this.selectable);

  @override
  DataRow? getRow(int index) {
    final Entity item = controller.filteredList[index];
    final selected = selectable ? controller.selectedMap[controller.getSelectedKey(item)]! : false;

    return DataRow(
      selected: selected,
      onSelectChanged: !selectable ? null : (val) =>
          controller.tableOnSelectChanged(controller.getSelectedKey(item), val!),
      cells: cellBuilder(item),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredList.length;

  @override
  int get selectedRowCount => controller.selectedMap.values.where((element) => element).length;
}