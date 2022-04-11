
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/nk/admin_nk_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/test-repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/test-repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/nk.dart';

class AdminNKPage extends View {
  final Nilai nilai;

  AdminNKPage({Key? key, required this.nilai}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminNKPageView(nilai);
}

class AdminNKPageView extends ViewState<AdminNKPage, AdminNKController> {
  AdminNKPageView(nilai)
      : super(AdminNKController(NilaiRepositoryImplTest(), MataPelajaranRepositoryImplTest(), nilai));

  @override
  Widget get view => Scaffold(
    key: globalKey,
    appBar: AppBar(
      title: Text(widget.nilai.santri.name),
    ),
    body: Center(
      child: Card(
        child: ControlledWidgetBuilder<AdminNKController>(
          builder: (context, controller) => CustomDataTable<NK>(
            controller: controller,
            title: 'NK ${widget.nilai.BaS.toReadableString()}',
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
    ),
  );
}