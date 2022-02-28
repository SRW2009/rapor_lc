
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/usecases/auth/forgot_password.dart';
import 'package:rapor_lc/domain/usecases/auth/login.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class LoginPresenter extends Presenter {
  late Function(bool e) authOnNext;
  late Function(dynamic e) authOnError;

  late Function forgotPasswordOnNext;
  late Function(dynamic e) forgotPasswordOnError;

  final LoginUseCase _loginUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  LoginPresenter(authRepo) :
        _loginUseCase = LoginUseCase(authRepo),
        _forgotPasswordUseCase = ForgotPasswordUseCase(authRepo);

  void doLogin(User user) => _loginUseCase.execute(_DoLoginObserver(this), UseCaseParams<User>(user));
  void doForgotPassword(String email) => _forgotPasswordUseCase.execute(_DoForgetPasswordObserver(this), UseCaseParams<String>(email));

  @override
  void dispose() {
    _loginUseCase.dispose();
    _forgotPasswordUseCase.dispose();
  }
}

class _DoLoginObserver extends Observer<UseCaseResponse<bool>> {
  LoginPresenter presenter;

  _DoLoginObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.authOnError(e);
  }

  @override
  void onNext(UseCaseResponse<bool>? response) {
    presenter.authOnNext(response!.response);
  }
}

class _DoForgetPasswordObserver extends Observer<UseCaseResponse<void>> {
  LoginPresenter presenter;

  _DoForgetPasswordObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.forgotPasswordOnError(e);
  }

  @override
  void onNext(UseCaseResponse<void>? response) {
    presenter.forgotPasswordOnNext();
  }
}