
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/admin_home_setting_controller.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/ui/nk-enabled-grade/setting_nk_enabled_grade_controller.dart';
import 'package:rapor_lc/app/widgets/custom_datatable.dart';
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_checkbox.dart';
import 'package:rapor_lc/app/widgets/style.dart';

class SettingNKEnabledGradeUI extends View {
  final AdminHomeSettingController parentController;

  SettingNKEnabledGradeUI({Key? key, required this.parentController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingNKEnabledGradeUIView();
}

class SettingNKEnabledGradeUIView
    extends ViewState<SettingNKEnabledGradeUI, SettingNKEnabledGradeController>
    with CustomWidgetStyle {
  SettingNKEnabledGradeUIView()
      : super(SettingNKEnabledGradeController());

  @override
  Widget get view => Column(
    key: globalKey,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Card(
          child: ControlledWidgetBuilder<SettingNKEnabledGradeController>(
            builder: (context, controller) {
              return CustomDataTable<NKEnabledGradeTypeEntry>(
                controller: controller,
                title: 'Nilai NK yang aktif',
                tableHeaders: const [
                  'Nama Variabel',
                  'Mesjid',
                  'Kelas',
                  'Asrama',
                ],
                tableContentBuilder: (item) => [
                  DataCell(Text(item.key.toString())),
                  DataCell(FormInputFieldCheckBox(
                    null,
                    item.value['mesjid'] ?? true,
                    (val) => controller.updateItem(item, 'mesjid', val),
                  )),
                  DataCell(FormInputFieldCheckBox(
                    null,
                    item.value['kelas'] ?? true,
                    (val) => controller.updateItem(item, 'kelas', val),
                  )),
                  DataCell(FormInputFieldCheckBox(
                    null,
                    item.value['asrama'] ?? true,
                    (val) => controller.updateItem(item, 'asrama', val),
                  )),
                ],
                selectable: false,
              );
            }
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ControlledWidgetBuilder<SettingNKEnabledGradeController>(
            builder: (context, controller) => Row(
              children: [
                OutlinedButton.icon(
                  onPressed: controller.hasChanged
                      ? controller.onDiscard
                      : null,
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
            )
        ),
      ),
    ],
  );
}