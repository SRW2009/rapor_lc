
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client-col/home/ui/record/home_record_controller.dart';
import 'package:rapor_lc/app/widgets/searchbar.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/data/repositories/relation_repo_impl.dart';

class HomeRecordUI extends View {
  HomeRecordUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeSantriUIView();
}

class HomeSantriUIView extends ViewState<HomeRecordUI, HomeRecordController> {
  HomeSantriUIView()
      : super(HomeRecordController(RelationRepositoryImpl()));

  @override
  Widget get view => Container(
    key: globalKey,
    child: ControlledWidgetBuilder<HomeRecordController>(
      builder: (context, controller) {
        if (controller.santriListState == RequestState.loaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Searchbar(controller.onSearch),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.shownSantriList.length,
                  itemBuilder: (_, i) => _itemBuilder(controller, i),
                ),
              ),
            ],
          );
        }
        if (controller.santriListState == RequestState.none) {
          return Center(
            child: Text('Belum ada santri. \nHubungi Admin untuk menginput relasi anda dan santri anda.'),
          );
        }
        if (controller.santriListState == RequestState.error) {
          return Center(
            child: Column(
              children: [
                const Text('Terjadi Masalah.'),
                ElevatedButton(
                  onPressed: controller.doGetMySantriList,
                  child: const Text('Reload'),
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
  );

  Widget _itemBuilder(HomeRecordController controller, int i) {
    var item = controller.shownSantriList[i];
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => controller.onTapItem(item.santri),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.santri.nis ?? '',
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.santri.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: item.isActive ? Colors.green : Colors.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(item.name ?? (item.isActive ? 'Aktif' : 'Nonaktif')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}