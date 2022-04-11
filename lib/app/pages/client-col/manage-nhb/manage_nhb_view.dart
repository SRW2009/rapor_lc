
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client-col/manage-nhb/manage_nhb_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/test-repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/test-repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

class ManageNHBPage extends View {
  ManageNHBPage(this.nilai, {Key? key}) : super(key: key);
  
  final Nilai nilai;

  @override
  State<StatefulWidget> createState() => ManageNHBPageView(nilai);
}

class ManageNHBPageView extends ViewState<ManageNHBPage, ManageNHBController> {
  ManageNHBPageView(nilai)
      : super(ManageNHBController(NilaiRepositoryImplTest(), MataPelajaranRepositoryImplTest(), nilai));

  @override
  Widget get view => SizedBox(
    key: globalKey,
    child: ControlledWidgetBuilder<ManageNHBController>(
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
                child: CustomDataTable<NHB>(
                  controller: controller,
                  title: 'NHB',
                  tableHeaders: const [
                    'No',
                    'Nama Mapel',
                    'Nilai Harian',
                    'Nilai Bulanan',
                    'Nilai Projek',
                    'Nilai Akhir',
                    'Akumulasi',
                    'Predikat',
                    'Action',
                  ],
                  tableContentBuilder: (item) => [
                    DataCell(Text(item.no.toString())),
                    DataCell(Text(item.pelajaran.name)),
                    DataCell(Text(item.nilai_harian.toString())),
                    DataCell(Text(item.nilai_bulanan.toString())),
                    DataCell(Text(item.nilai_projek.toString())),
                    DataCell(Text(item.nilai_akhir.toString())),
                    DataCell(Text(item.akumulasi.toString())),
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