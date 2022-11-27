
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/admin-col/home/ui/setting/admin_home_setting_presenter.dart';
import 'package:rapor_lc/app/subclasses/lazy_controller_method.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/domain/entities/setting.dart';

class AdminHomeSettingController extends Controller with LazyControllerMethod {
  RequestState settingState = RequestState.loaded;
  int refreshCount = 0;

  final AdminHomeSettingPresenter _presenter;
  AdminHomeSettingController(settingRepository)
      : _presenter = AdminHomeSettingPresenter(settingRepository),
        super();

  void refresh() {
    refreshCount++;
    refreshUI();
  }

  void reload() => getSettingList();

  @override
  void initListeners() {
    _presenter.getSettingListState = (s) {
      settingState = s;
      if (settingState == RequestState.loaded)
        refreshCount++;
      refreshUI();
    };
    _presenter.createSettingStatus = (s) => onResponseStatus(getContext(), 'Create Setting', s, getSettingList);
    _presenter.updateSettingStatus = (s) => onResponseStatus(getContext(), 'Update Setting', s, getSettingList);
    _presenter.deleteSettingStatus = (s) => onResponseStatus(getContext(), 'Delete Setting', s, getSettingList);
  }

  void getSettingList() {
    settingState = RequestState.loading;
    refreshUI();
    _presenter.doGetSettingList();
  }
  void createSetting(Setting s) => _presenter.doCreateSetting(s);
  void updateSetting(Setting s) => _presenter.doUpdateSetting(s);
  void deleteSetting(String id) => _presenter.doDeleteSetting([id]);

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }
}