
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client-col/manage-npb/manage_npb_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/test-repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/test-repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';

class ManageNPBPage extends View {
  ManageNPBPage(this.nilai, {Key? key}) : super(key: key);
  
  final Nilai nilai;

  @override
  State<StatefulWidget> createState() => ManageNPBPageView(nilai);
}

class ManageNPBPageView extends ViewState<ManageNPBPage, ManageNPBController> {
  ManageNPBPageView(nilai)
      : super(ManageNPBController(NilaiRepositoryImplTest(), MataPelajaranRepositoryImplTest(), nilai));

  @override
  Widget get view => SizedBox(
    key: globalKey,
    child: ControlledWidgetBuilder<ManageNPBController>(
      builder: (context, controller) {
        return WillPopScope(
          onWillPop: () async {
            controller.onExit();
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('${widget.nilai.BaS.toReadableString()} ${widget.nilai.tahunAjaran}'),
            ),
            body: Center(
              child: Card(
                child: CustomDataTable<NPB>(
                  controller: controller,
                  title: 'NPB',
                  tableHeaders: const [
                    'No',
                    'Nama Mapel',
                    'Presensi',
                    '/n',
                    'Tipe',
                    'Action',
                  ],
                  tableContentBuilder: (item) => [
                    DataCell(Text(item.no.toString())),
                    DataCell(Text(item.pelajaran.name)),
                    DataCell(Text(item.presensi)),
                    DataCell(Text(((item is NPBMO)
                        ? item.n
                        : widget.nilai.BaS.semester
                    ).toString())),
                    DataCell(Text((item is NPBMO)
                        ? 'Masa Observasi'
                        : 'Paska Observasi'
                    )),
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
        );
      }
    ),
  );
}