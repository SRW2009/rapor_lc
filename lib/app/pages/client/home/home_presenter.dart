
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/usecases/auth/get_current_user.dart';
import 'package:rapor_lc/domain/usecases/auth/logout.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class HomePresenter extends Presenter {
  late Function(Teacher?) getCurrentUserOnNext;
  late Function() logoutOnComplete;

  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final LogoutUseCase _logoutUseCase;
  HomePresenter(authRepository)
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

class _GetCurrentUserObserver extends Observer<UseCaseResponse<Teacher?>> {
  final HomePresenter presenter;

  _GetCurrentUserObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
  }

  @override
  void onNext(UseCaseResponse<Teacher?>? response) {
    presenter.getCurrentUserOnNext(response!.response);
  }
}

class _LogoutObserver extends Observer<UseCaseResponse<void>> {
  final HomePresenter presenter;

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