
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/entities/setting.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/usecases/auth/login_admin.dart';
import 'package:rapor_lc/domain/usecases/auth/login_teacher.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/setting/get_setting_list.dart';

class LoginPresenter extends Presenter {
  late Function(int) authOnNext;
  late Function(dynamic) authOnError;
  late Function(RequestState) getSettingListState;

  final LoginAdminUseCase _loginAdminUseCase;
  final LoginTeacherUseCase _loginTeacherUseCase;
  final GetSettingListUseCase _getSettingListUseCase;
  LoginPresenter(authRepo, settingRepo)
      : _loginAdminUseCase = LoginAdminUseCase(authRepo),
        _loginTeacherUseCase = LoginTeacherUseCase(authRepo),
        _getSettingListUseCase = GetSettingListUseCase(settingRepo);

  void doLoginTeacher(Teacher user) => _loginTeacherUseCase.execute(
      _DoLoginObserver(this), UseCaseParams(user));
  void doLoginAdmin(Admin user) => _loginAdminUseCase.execute(
      _DoLoginObserver(this), UseCaseParams(user));
  void getSettingList() => _getSettingListUseCase.execute(_GetSettingListObserver(this));

  @override
  void dispose() {
    _loginAdminUseCase.dispose();
    _loginTeacherUseCase.dispose();
    _getSettingListUseCase.dispose();
  }
}

class _DoLoginObserver extends Observer<UseCaseResponse<int>> {
  LoginPresenter presenter;

  _DoLoginObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.authOnError(e);
  }

  @override
  void onNext(response) {
    presenter.authOnNext(response!.response);
  }
}

class _GetSettingListObserver implements Observer<UseCaseResponse<List<Setting>>> {
  final LoginPresenter _splashPresenter;

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