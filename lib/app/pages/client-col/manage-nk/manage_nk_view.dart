
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client-col/manage-nk/manage_nk_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/test-repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/test-repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class ManageNKPage extends View {
  ManageNKPage(this.nilai, {Key? key}) : super(key: key);
  
  final Nilai nilai;

  @override
  State<StatefulWidget> createState() => ManageNKPageView(nilai);
}

class ManageNKPageView extends ViewState<ManageNKPage, ManageNKController> {
  ManageNKPageView(nilai)
      : super(ManageNKController(NilaiRepositoryImplTest(), MataPelajaranRepositoryImplTest(), nilai));

  @override
  Widget get view => SizedBox(
    key: globalKey,
    child: ControlledWidgetBuilder<ManageNKController>(
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
                child: CustomDataTable<NK>(
                  controller: controller,
                  title: 'NK',
                  tableHeaders: const [
                    'No',
                    'Nama Variabel',
                    'Nilai Mesjid',
                    'Nilai Kelas',
                    'Nilai Asrama',
                    'Akumulatif',
                    'Predikat',
                    'Action',
                  ],
                  tableContentBuilder: (item) => [
                    DataCell(Text(item.no.toString())),
                    DataCell(Text(item.nama_variabel)),
                    DataCell(Text(item.nilai_mesjid.toString())),
                    DataCell(Text(item.nilai_kelas.toString())),
                    DataCell(Text(item.nilai_asrama.toString())),
                    DataCell(Text(item.akumulatif.toString())),
                    DataCell(Text(item.predikat)),
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