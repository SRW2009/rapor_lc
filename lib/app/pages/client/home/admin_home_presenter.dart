
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/usecases/auth/get_current_user.dart';
import 'package:rapor_lc/domain/usecases/auth/logout.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/nhb/get_nhb_list_admin.dart';
import 'package:rapor_lc/domain/usecases/nk/get_nk_list_admin.dart';
import 'package:rapor_lc/domain/usecases/npb/get_npb_list_admin.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list_admin.dart';

class AdminHomePresenter extends Presenter {
  late Function(User?) getCurrentUserOnNext;
  late Function() logoutOnComplete;

  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final LogoutUseCase _logoutUseCase;
  AdminHomePresenter(authRepository)
      : _getCurrentUserUseCase = GetCurrentUserUseCase(authRepository),
        _logoutUseCase = LogoutUseCase(authRepository);

  void doGetCurrentUser() => _getCurrentUserUseCase.execute(_GetCurrentUserObserver(this));
  void doLogout() => _logoutUseCase.execute(_LogoutObserver(this));

  @override
  void dispose() {
    _getCurrentUserUseCase.dispose();
    _logoutUseCase.dispose();
  }
}

class _GetCurrentUserObserver extends Observer<UseCaseResponse<User?>> {
  final AdminHomePresenter presenter;

  _GetCurrentUserObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
  }

  @override
  void onNext(UseCaseResponse<User?>? response) {
    presenter.getCurrentUserOnNext(response!.response);
  }
}

class _LogoutObserver extends Observer<UseCaseResponse<void>> {
  final AdminHomePresenter presenter;

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