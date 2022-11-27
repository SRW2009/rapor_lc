
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/domain/entities/setting.dart';
import 'package:rapor_lc/domain/usecases/auth/get_auth_status.dart';
import 'package:rapor_lc/domain/usecases/auth/logout.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/setting/get_setting_list.dart';

class SplashPresenter extends Presenter {
  late Function(int) getAuthStatusOnNext;
  late Function() logoutOnComplete;
  late Function(RequestState) getSettingListState;

  final GetAuthStatusUseCase _getAuthStatusUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetSettingListUseCase _getSettingListUseCase;
  SplashPresenter(authRepo, settingRepo) :
        _getAuthStatusUseCase = GetAuthStatusUseCase(authRepo),
        _logoutUseCase = LogoutUseCase(authRepo),
        _getSettingListUseCase = GetSettingListUseCase(settingRepo);

  void getAuthStatus() => _getAuthStatusUseCase.execute(_GetAuthStatusObserver(this));
  void doLogout() => _logoutUseCase.execute(_LogoutObserver(this));
  void getSettingList() => _getSettingListUseCase.execute(_GetSettingListObserver(this));

  @override
  void dispose() => _getAuthStatusUseCase.dispose();
}

class _GetAuthStatusObserver implements Observer<UseCaseResponse<int>> {
  final SplashPresenter _splashPresenter;

  _GetAuthStatusObserver(this._splashPresenter);

  @override
  void onNext(isAuth) {
    _splashPresenter.getAuthStatusOnNext(isAuth!.response);
  }

  @override
  void onComplete() {}

  @override
  void onError(e) {
    // if any errors occured, proceed as if the teacher is not logged in
    print(e);
    _splashPresenter.getAuthStatusOnNext(0);
  }
}

class _GetSettingListObserver implements Observer<UseCaseResponse<List<Setting>>> {
  final SplashPresenter _splashPresenter;

  _GetSettingListObserver(this._splashPresenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _splashPresenter.getSettingListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<Setting>>? response) {
    _splashPresenter.getSettingListState(RequestState.loaded);
  }
}

class _LogoutObserver extends Observer<UseCaseResponse<void>> {
  final SplashPresenter presenter;

  _LogoutObserver(this.presenter);

  @override
  void onComplete() {
    presenter.logoutOnComplete();
  }

  @override
  void onError(e) {}

  @override
  void onNext(UseCaseResponse<void>? response) {}
}