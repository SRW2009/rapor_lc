
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client-col/manage-nilai/manage_nilai_controller.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/app/widgets/searchbar.dart';
import 'package:rapor_lc/data/helpers/chart/chart_repo.dart';
import 'package:rapor_lc/data/test-repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

class ManageNilaiPage extends View {
  ManageNilaiPage(this.santri, this.nilaiList, {Key? key}) : super(key: key);
  
  final Santri santri;
  final List<Nilai> nilaiList;

  @override
  State<StatefulWidget> createState() => ManageNilaiPageView(santri, nilaiList);
}

class ManageNilaiPageView extends ViewState<ManageNilaiPage, ManageNilaiController> {
  ManageNilaiPageView(santri, nilaiList)
      : super(ManageNilaiController(NilaiRepositoryImplTest(), santri, nilaiList, ChartRepository()));

  @override
  Widget get view => SizedBox(
    key: globalKey,
    child: ControlledWidgetBuilder<ManageNilaiController>(
      builder: (context, controller) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop(controller.normalList);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.santri.name),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Searchbar(controller.tableSearch),
                  Expanded(
                    child: (controller.dataTableState != RequestState.loading)
                        ? ListView.builder(
                      itemCount: controller.filteredList.length,
                      itemBuilder: (_, i) => _itemBuilder(controller, i),
                    )
                        : const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
            persistentFooterButtons: [
              TextButton(
                child: const Text('IMPORT'),
                onPressed: () {},
              ),
              TextButton(
                child: const Text('EXPORT'),
                onPressed: () {},
              ),
              TextButton(
                child: const Text('NEW'),
                onPressed: controller.tableOnAdd,
              ),
            ],
          ),
        );
      }
    ),
  );

  Widget _itemBuilder(ManageNilaiController controller, int i) {
    var item = controller.filteredList[i];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.tahunAjaran,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                PopupMenuButton<int>(
                  padding: EdgeInsets.zero,
                  onSelected: (i) {
                    if (i == 1) {
                      controller.tableOnEdit(item);
                    }
                    else if (i == 2) {
                      controller.selectedMap[controller.getSelectedKey(item)] = true;
                      controller.tableOnDelete();
                    }
                  },
                  itemBuilder: (c) => [
                    const PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit'),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              item.BaS.toReadableString(),
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 10),
            ExpansionTile(
              title: const Text('NHB'),
              childrenPadding: const EdgeInsets.all(16.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.nhb?.isNotEmpty ?? false) Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'First NHB\n',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(text: 'Nama Pelajaran: '),
                        TextSpan(
                          text: item.nhb!.first.pelajaran.name,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: '\nAkumulasi: '),
                        TextSpan(
                          text: item.nhb!.first.akumulasi.toString(),
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: '\nPredikat: '),
                        TextSpan(
                          text: item.nhb!.first.predikat,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                if ((item.nhb?.length ?? 0) > 1) Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'Last NHB\n',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(text: 'Nama Pelajaran: '),
                        TextSpan(
                          text: item.nhb!.last.pelajaran.name,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: '\nAkumulasi: '),
                        TextSpan(
                          text: item.nhb!.last.akumulasi.toString(),
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: '\nPredikat: '),
                        TextSpan(
                          text: item.nhb!.last.predikat,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    child: const Text('Manage NHB'),
                    onPressed: () => controller.onTapNHB(item),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('NK'),
              childrenPadding: const EdgeInsets.all(16.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.nk?.isNotEmpty ?? false) Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'First NK\n',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(text: 'Nama Variabel: '),
                        TextSpan(
                          text: item.nk!.first.nama_variabel,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: '\nAkumulatif: '),
                        TextSpan(
                          text: item.nk!.first.akumulatif.toString(),
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: '\nPredikat: '),
                        TextSpan(
                          text: item.nk!.first.predikat,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                if ((item.nk?.length ?? 0) > 1) Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'Last NK\n',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(text: 'Nama Variabel: '),
                        TextSpan(
                          text: item.nk!.last.nama_variabel,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: '\nAkumulatif: '),
                        TextSpan(
                          text: item.nk!.last.akumulatif.toString(),
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: '\nPredikat: '),
                        TextSpan(
                          text: item.nk!.last.predikat,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    child: const Text('Manage NK'),
                    onPressed: () => controller.onTapNK(item),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('NPB'),
              childrenPadding: const EdgeInsets.all(16.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.npb?.isNotEmpty ?? false) Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'First NPB\n',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(text: 'Nama Pelajaran: '),
                        TextSpan(
                          text: item.npb!.first.pelajaran.name,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: '\nPresensi: '),
                        TextSpan(
                          text: item.npb!.first.presensi.toString(),
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: '\n/n: '),
                        TextSpan(
                          text: item.npb!.first.n.toString(),
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                if ((item.npb?.length ?? 0) > 1) Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'Last NPB\n',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(text: 'Nama Pelajaran: '),
                        TextSpan(
                          text: item.npb!.last.pelajaran.name,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: '\nPresensi: '),
                        TextSpan(
                          text: item.npb!.last.presensi,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        TextSpan(text: '\n/n: '),
                        TextSpan(
                          text: item.npb!.first.n.toString(),
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    child: const Text('Manage NPB'),
                    onPressed: () => controller.onTapNPB(item),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}