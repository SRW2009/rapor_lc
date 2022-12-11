
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/admin_home_setting_controller.dart';
import 'package:rapor_lc/app/utils/constants.dart';
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/domain/entities/setting.dart';

class SettingNHBMinValToPassController extends Controller {
  final minValController = TextEditingController(text: LoadedSettings.nhbMinValToPass.toString());

  void onSave(AdminHomeSettingController parentController) {
    if (LoadedSettings.nhbMinValToPassId == -1) {
      parentController.createSetting(Setting(
        0,
        SettingVariables.nhbMinValToPass,
        int.tryParse(minValController.text),
      ));
    } else {
      parentController.updateSetting(Setting(
        LoadedSettings.nhbMinValToPassId,
        SettingVariables.nhbMinValToPass,
        int.tryParse(minValController.text),
      ));
    }
  }

  void onDiscard() {
    minValController.text = LoadedSettings.nhbMinValToPass.toString();
    refreshUI();
  }

  @override
  void initListeners() {}
}