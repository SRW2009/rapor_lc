
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/client-col/home/home_controller.dart';
import 'package:rapor_lc/app/utils/constants.dart';
import 'package:rapor_lc/app/widgets/form_field/form_decoration.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';

import 'home_account_controller.dart';

class HomeAccountUI extends View {
  final HomeController homeController;

  HomeAccountUI({Key? key, required this.homeController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeDashboardUIView();
}

class AdminHomeDashboardUIView extends ViewState<HomeAccountUI, HomeAccountController> {
  AdminHomeDashboardUIView()
      : super(HomeAccountController());

  @override
  Widget get view => Container(
    key: globalKey,
    child: Center(
      child: ControlledWidgetBuilder<HomeAccountController>(
        builder: (context, controller) {
          return SingleChildScrollView(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Resources.background),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          Resources.logo,
                          height: 150.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    if (widget.homeController.user != null)
                      ..._loadedUser(widget.homeController.user!),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: widget.homeController.onLogout,
                        child: Text('Logout'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    ),
  );

  static const _vertPadding = 24.0;
  List<Widget> _loadedUser(Teacher user) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: _vertPadding),
        child: TextField(
          controller: TextEditingController(text: user.name),
          readOnly: true,
          decoration: inputDecoration.copyWith(
            prefixText: 'Nama  ',
            prefixStyle: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: _vertPadding),
        child: TextField(
          controller: TextEditingController(text: user.email),
          readOnly: true,
          decoration: inputDecoration.copyWith(
            prefixText: 'Email  ',
            prefixStyle: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: _vertPadding),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: TextEditingController(text: user.divisi.name),
                readOnly: true,
                decoration: inputDecoration.copyWith(
                  prefixText: 'Nama Divisi  ',
                  prefixStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.withOpacity(.20),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.only(left: 16),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4.5),
              child: Row(
                children: [
                  Text(
                    'Kadiv  ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Checkbox(
                    value: user.isLeader ?? false,
                    onChanged: (val) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }
}