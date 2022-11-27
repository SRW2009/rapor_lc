
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/mapel_repo_impl.dart';
import 'package:rapor_lc/data/repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/domain/entities/nhb_semester.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';

import 'manage_nhb_semester_controller.dart';

class ManageNHBSemesterPage extends View {
  ManageNHBSemesterPage({Key? key, required this.nilai}) : super(key: key);

  final Nilai nilai;

  @override
  ManageNHBPageView createState() => ManageNHBPageView(nilai);
}

class ManageNHBPageView extends ViewState<ManageNHBSemesterPage, ManageNHBSemesterController> {
  ManageNHBPageView(nilai)
      : super(ManageNHBSemesterController(NilaiRepositoryImpl(), MataPelajaranRepositoryImpl(), nilai));

  @override
  Widget get view => Container(
    key: globalKey,
    child: ControlledWidgetBuilder<ManageNHBSemesterController>(
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
              child: CustomDataTable<NHBSemester>(
                controller: controller,
                title: 'NHB Semester ${widget.nilai.timeline.toExcelString()}',
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
          floatingActionButton: (Platform.isAndroid) ? FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: controller.onSave,
          ) : null,
          persistentFooterButtons: (Platform.isWindows) ? [
            TextButton(
              child: const Text('SIMPAN'),
              onPressed: controller.onSave,
            ),
          ] : null,
        ),
      ),
    ),
  );
}