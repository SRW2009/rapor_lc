
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin/home/ui/santri/admin_home_santri_controller.dart';
import 'package:rapor_lc/data/repositories/santri_repo_impl.dart';

class AdminHomeSantriUI extends View {
  AdminHomeSantriUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeSantriUIView();
}

class AdminHomeSantriUIView extends ViewState<AdminHomeSantriUI, AdminHomeSantriController> {
  AdminHomeSantriUIView()
      : super(AdminHomeSantriController(SantriRepositoryImpl()));

  @override
  Widget get view => throw UnimplementedError();

}