
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SplashPresenter extends Presenter {
  late Function getAuthStatusOnNext;
  late Function getAuthStatusOnComplete;

  GetAuthStatusUseCase _getAuthStatusUseCase;

  SplashPresenter(authRepo) {
    _getAuthStatusUseCase = GetAuthStatusUseCase(authRepo);
  }

  void getAuthStatus() => _getAuthStatusUseCase.execute(_SplashObserver(this));
  void dispose() => _getAuthStatusUseCase.dispose();
}

class _SplashObserver implements Observer<bool> {
  final SplashPresenter _splashPresenter;

  _SplashObserver(this._splashPresenter);

  @override
  void onNext(isAuth) {
    _splashPresenter.getAuthStatusOnNext(isAuth);
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