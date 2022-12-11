
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/admin_home_setting_controller.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/style.dart';

import 'setting_nk_advice_controller.dart';

class SettingNKAdviceUI extends View {
  final AdminHomeSettingController parentController;

  SettingNKAdviceUI({Key? key, required this.parentController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingNKAdviceUIView();
}

class SettingNKAdviceUIView
    extends ViewState<SettingNKAdviceUI, SettingNKAdviceController>
    with CustomWidgetStyle {
  SettingNKAdviceUIView()
      : super(SettingNKAdviceController());

  @override
  Widget get view => ControlledWidgetBuilder<SettingNKAdviceController>(
    builder: (context, controller) {
      return Column(
        key: globalKey,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormInputField(
            label: 'Nasehat Dewan Guru',
            controller: controller.adviceController,
            maxLines: 15,
            inputType: TextInputType.multiline,
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