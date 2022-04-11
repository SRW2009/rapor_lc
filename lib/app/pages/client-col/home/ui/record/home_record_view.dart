
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client-col/home/ui/record/home_record_controller.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/app/widgets/searchbar.dart';
import 'package:rapor_lc/data/test-repositories/nilai_repo_impl.dart';
import 'package:rapor_lc/data/test-repositories/santri_repo_impl.dart';

class HomeRecordUI extends View {
  HomeRecordUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeSantriUIView();
}

class HomeSantriUIView extends ViewState<HomeRecordUI, HomeRecordController> {
  HomeSantriUIView()
      : super(HomeRecordController(SantriRepositoryImplTest(), NilaiRepositoryImplTest()));

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
          return const Card(
            child: Center(
              child: Text('Belum ada Santri. \nHubungi Admin untuk menginput Santri.'),
            ),
          );
        }
        if (controller.santriListState == RequestState.error) {
          return Card(
            child: Center(
              child: Column(
                children: [
                  const Text('Terjadi Masalah.'),
                  ElevatedButton(
                    onPressed: controller.doGetSantriList,
                    child: const Text('Reload'),
                  ),
                ],
              ),
            ),
          );
        }
        return const Card(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    ),
  );

  Widget _itemBuilder(HomeRecordController controller, int i) {
    var item = controller.shownSantriList[i];
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => controller.onTapItem(item),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.nis ?? '',
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}