
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/subclasses/lazy_presenter_observer.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/setting.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/setting/create_setting.dart';
import 'package:rapor_lc/domain/usecases/setting/delete_setting.dart';
import 'package:rapor_lc/domain/usecases/setting/get_setting_list.dart';
import 'package:rapor_lc/domain/usecases/setting/update_setting.dart';

class AdminHomeSettingPresenter extends Presenter {
  late Function(RequestState) getSettingListState;
  late Function(RequestStatus) createSettingStatus;
  late Function(RequestStatus) updateSettingStatus;
  late Function(RequestStatus) deleteSettingStatus;

  final GetSettingListUseCase _getSettingListUseCase;
  final CreateSettingUseCase _createSettingUseCase;
  final UpdateSettingUseCase _updateSettingUseCase;
  final DeleteSettingUseCase _deleteSettingUseCase;
  AdminHomeSettingPresenter(settingRepo) :
        _getSettingListUseCase = GetSettingListUseCase(settingRepo),
        _createSettingUseCase = CreateSettingUseCase(settingRepo),
        _updateSettingUseCase = UpdateSettingUseCase(settingRepo),
        _deleteSettingUseCase = DeleteSettingUseCase(settingRepo);

  void doGetSettingList() {
    getSettingListState(RequestState.loading);
    _getSettingListUseCase.execute(_GetSettingListObserver(this));
  }
  void doCreateSetting(Setting setting) {
    createSettingStatus(RequestStatus.loading);
    _createSettingUseCase.execute(
      LazyPresenterObserver(createSettingStatus), UseCaseParams(setting),
    );
  }
  void doUpdateSetting(Setting setting) {
    updateSettingStatus(RequestStatus.loading);
    _updateSettingUseCase.execute(
      LazyPresenterObserver(updateSettingStatus), UseCaseParams(setting),
    );
  }
  void doDeleteSetting(List<String> ids) {
    deleteSettingStatus(RequestStatus.loading);
    _deleteSettingUseCase.execute(
      LazyPresenterObserver(deleteSettingStatus), UseCaseParams(ids),
    );
  }

  @override
  void dispose() {
    _getSettingListUseCase.dispose();
    _createSettingUseCase.dispose();
    _updateSettingUseCase.dispose();
    _deleteSettingUseCase.dispose();
  }
}

class _GetSettingListObserver extends Observer<UseCaseResponse<List<Setting>>> {
  final AdminHomeSettingPresenter _presenter;

  _GetSettingListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getSettingListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<Setting>>? response) {
    final list = response!.response;
    _presenter.getSettingListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}