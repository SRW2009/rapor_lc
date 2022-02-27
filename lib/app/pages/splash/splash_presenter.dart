
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/domain/usecases/auth/get_auth_status.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class SplashPresenter extends Presenter {
  late Function getAuthStatusOnNext;
  late Function getAuthStatusOnComplete;

  final GetAuthStatusUseCase _getAuthStatusUseCase;
  SplashPresenter(authRepo) : _getAuthStatusUseCase = GetAuthStatusUseCase(authRepo);

  void getAuthStatus() => _getAuthStatusUseCase.execute(_GetAuthStatusObserver(this));

  @override
  void dispose() => _getAuthStatusUseCase.dispose();
}

class _GetAuthStatusObserver implements Observer<UseCaseResponse<bool>> {
  final SplashPresenter _splashPresenter;

  _GetAuthStatusObserver(this._splashPresenter);

  @override
  void onNext(isAuth) {
    _splashPresenter.getAuthStatusOnNext(isAuth?.response);
  }

  @override
  void onComplete() {
    _splashPresenter.getAuthStatusOnComplete();
  }

  @override
  void onError(e) {
    // if any errors occured, proceed as if the user is not logged in
    _splashPresenter.getAuthStatusOnNext(false);
    onComplete();
  }
}