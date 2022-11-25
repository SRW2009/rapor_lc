
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/manage-npb/manage_npb_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/domain/entities/npb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class ManageNPBPage extends View {
  ManageNPBPage({Key? key, required this.nilai}) : super(key: key);

  final Nilai nilai;

  @override
  ManageNPBPageView createState() => ManageNPBPageView(nilai);
}

class ManageNPBPageView extends ViewState<ManageNPBPage, ManageNPBController> {
  ManageNPBPageView(nilai)
      : super(ManageNPBController(NilaiRepositoryImpl(), MataPelajaranRepositoryImpl(), nilai));

  @override
  Widget get view => Container(
    key: globalKey,
    child: ControlledWidgetBuilder<ManageNPBController>(
      builder: (context, controller) => WillPopScope(
        onWillPop: () async {
          controller.onExit();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.nilai.santri.name),
          ),
          body: Center(
            child: Card(
              child: CustomDataTable<NPB>(
                controller: controller,
                title: 'NPB ${widget.nilai.timeline.toExcelString()}',
                tableHeaders: const [
                  'No',
                  'Nama Mapel',
                  'N',
                  'Action',
                ],
                tableContentBuilder: (item) => [
                  DataCell(Text(item.no.toString())),
                  DataCell(Text(item.pelajaran.name)),
                  DataCell(Text(item.n.toString())),
                  DataCell(IconButton(
                    onPressed: () => controller.tableOnEdit(item),
                    icon: const Icon(Icons.edit),
                  )),
                ],
              ),
            ),
          ),
          persistentFooterButtons: [
            TextButton(
              child: const Text('SIMPAN'),
              onPressed: controller.onSave,
            ),
          ],
        ),
      ),
    ),
  );
}