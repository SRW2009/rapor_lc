

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/admin_home_setting_controller.dart';
import 'package:rapor_lc/app/utils/constants.dart';
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/domain/entities/setting.dart';

class SettingNKAdviceController extends Controller {
  SettingNKAdviceController();
  final adviceController = TextEditingController(text: LoadedSettings.nkAdvice);

  void onSave(AdminHomeSettingController parentController) {
    if (LoadedSettings.nkAdviceId == -1) {
      parentController.createSetting(Setting(
        0,
        SettingVariables.nkAdvice,
        adviceController.text,
      ));
    } else {
      parentController.updateSetting(Setting(
        LoadedSettings.nkAdviceId,
        SettingVariables.nkAdvice,
        adviceController.text,
      ));
    }
  }

  void onDiscard() {
    adviceController.text = LoadedSettings.nkAdvice ?? '';
    refreshUI();
  }

  @override
  void initListeners() {}
}