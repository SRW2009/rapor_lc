
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/admin_home_setting_controller.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/ui/nk-enabled-grade/setting_nk_enabled_grade_view.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/ui/nk-variable/setting_nk_variable_view.dart';
import 'package:rapor_lc/app/utils/constants.dart';
import 'package:rapor_lc/app/widgets/style.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/data/repositories/setting_repo_impl.dart';

import 'ui/nhb-min-val-to-pass/setting_nhb_min_val_to_pass_view.dart';
import 'ui/nk-advice/setting_nk_advice_view.dart';

class AdminHomeSettingUI extends View {
  AdminHomeSettingUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AdminHomeSettingUIView();
}

class AdminHomeSettingUIView
    extends ViewState<AdminHomeSettingUI, AdminHomeSettingController>
    with CustomWidgetStyle {

  ScrollController mainScrollController = ScrollController();

  AdminHomeSettingUIView() : super(AdminHomeSettingController(
    SettingRepositoryImpl(),
  ));

  @override
  Widget get view => ListView(
    key: globalKey,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
    controller: mainScrollController,
    children: [
      _NHBSegment(),
      _NKSegment(),
    ],
  );

  Widget _NHBSegment() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header('NHB'),

        // NHB Minimal value to pass
        _title('Pengaturan nilai minimal kelulusan.'),
        _desc('Atur nilai minimal kelulusan NHB. pengaturan ini juga akan mempengaruhi keterangan lulus/tidak di rapor halaman NPB.'),
        SizedBox(
          height: MediaQuery.of(context).size.height*.3,
          child: ControlledWidgetBuilder<AdminHomeSettingController>(
            builder: (context, controller) => SettingNHBMinValToPassUI(parentController: controller),
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget _NKSegment() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header('NK'),

        // NK Variables
        _title('Pengaturan variabel NK.'),
        _desc('Atur variabel NK yang muncul di rapor.'),
        SizedBox(
          height: MediaQuery.of(context).size.height*.5,
          child: ControlledWidgetBuilder<AdminHomeSettingController>(
            builder: (context, controller) => SettingNKVariableUI(refreshSettingFunc: controller.refresh),
          ),
        ),
        Divider(),

        // NK Enabled Grade
        _title('Pengaturan nilai NK yang aktif.'),
        _desc('Atur nilai NK yang ingin diaktifkan atau dinonaktifkan. '
            'Nilai yang dinonaktifkan tidak akan dihitung nilai rata-rata keseluruhan NK.'),
        SizedBox(
          height: MediaQuery.of(context).size.height*.7,
          child: ControlledWidgetBuilder<AdminHomeSettingController>(
            builder: (context, controller) => _stateListener(
              state: controller.settingState,
              refresh: controller.reload,
              child: SettingNKEnabledGradeUI(
                key: ValueKey(controller.refreshCount),
                parentController: controller,
              ),
            ),
          ),
        ),
        Divider(),

        // NK Advice
        _title('Pengaturan Nasehat Dewan Guru'),
        _desc('Atur bagaimana format pesan dari "Nasehat Dewan Guru" di rapor.\n\n'
            'Variabel:\n'
            '{[variable name]:val} = Tampilkan nilai akumulasi. (contoh: 76, 80, dll)\n'
            '{[variable name]:inpred} = Tampilkan nilai inisial predikat. (contoh: "BSB", "BA", dll)\n'
            '{[variable name]:pred} = Tampilkan nilai predikat. (contoh: "belum ada", dll)\n'
            '\n'
            'Contoh:\n'
            'input: "Inisiatif ananda dinilai {Inisiatif:pred}".\n'
            'output: "Inisiatif ananda dinilai belum ada."\n'
            '\n'
            'PENTING: [variable name] huruf kapital harus sesuai.'
        ),
        ControlledWidgetBuilder<AdminHomeSettingController>(
          builder: (context, controller) => SettingNKAdviceUI(parentController: controller),
        ),
        Divider(),
      ],
    );
  }

  Widget _header(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Text(text, style: settingHeaderStyle),
  );
  Widget _title(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(text, style: settingTitleStyle),
  );
  Widget _desc(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 14, top: 6),
    child: Text(text, style: settingDescStyle),
  );
  Widget _stateListener({required RequestState state, required Widget child, Function()? refresh}) {
    switch (state) {
      case RequestState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case RequestState.loaded:
        return child;
      case RequestState.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(Strings.errorMessage),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: refresh,
                child: const Text(Strings.reloadMessage),
              ),
            ],
          ),
        );
      case RequestState.none:
        return Center(
          child: Text(Strings.noDataMessage),
        );
    }
  }
}