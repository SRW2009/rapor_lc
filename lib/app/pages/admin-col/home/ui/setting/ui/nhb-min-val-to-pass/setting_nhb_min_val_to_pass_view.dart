
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/admin_home_setting_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_number.dart';
import 'package:rapor_lc/app/widgets/style.dart';

import 'setting_nhb_min_val_to_pass_controller.dart';

class SettingNHBMinValToPassUI extends View {
  final AdminHomeSettingController parentController;

  SettingNHBMinValToPassUI({Key? key, required this.parentController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingNHBMinValToPassUIView();
}

class SettingNHBMinValToPassUIView
    extends ViewState<SettingNHBMinValToPassUI, SettingNHBMinValToPassController>
    with CustomWidgetStyle {
  SettingNHBMinValToPassUIView()
      : super(SettingNHBMinValToPassController());

  @override
  Widget get view => ControlledWidgetBuilder<SettingNHBMinValToPassController>(
      builder: (context, controller) {
        return Column(
          key: globalKey,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormInputFieldNumber(
              'NHB nilai minimal kelulusan',
              controller.minValController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: controller.onDiscard,
                    style: dashboardBtnStyle,
                    icon: Icon(Icons.cancel),
                    label: Text('Batal'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () => controller.onSave(widget.parentController),
                    style: dashboardBtnStyle,
                    icon: Icon(Icons.save),
                    label: Text('Simpan'),
                  ),
                ],
              ),
            ),
          ],
        );
      }
  );
}