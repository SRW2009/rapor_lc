
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';
import 'package:rapor_lc/app/pages/client/home/ui/santri/home_santri_controller.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';

class HomeSantriUI extends View {
  HomeSantriUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeSantriUIView();
}

class HomeSantriUIView extends ViewState<HomeSantriUI, HomeSantriController> {
  HomeSantriUIView()
      : super(HomeSantriController(SantriRepositoryImpl()));

  @override
  Widget get view => Center(
    child: Card(
      key: globalKey,
      child: ControlledWidgetBuilder<HomeSantriController>(
        builder: (context, controller) {
          return CustomDataTable<Divisi>(
            controller: controller,
            title: 'Divisi',
            tableHeaders: const [
              'ID',
              'Nama',
              'Kadiv',
              'Action',
            ],
            tableContentBuilder: (item) => [
              DataCell(Text(item.id.toString())),
              DataCell(Text(item.name)),
              DataCell(Text(item.kadiv)),
              DataCell(IconButton(
                onPressed: () => controller.tableOnEdit(item),
                icon: const Icon(Icons.edit),
              )),
            ],
          );
        }
      ),
    ),
  );
}