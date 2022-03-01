
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/usecases/auth/forgot_password.dart';
import 'package:rapor_lc/domain/usecases/auth/login.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class LoginPresenter extends Presenter {
  late Function(int) authOnNext;
  late Function(dynamic) authOnError;
  late Function(bool) forgotPasswordOnNext;
  late Function(dynamic) forgotPasswordOnError;

  final LoginUseCase _loginUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  LoginPresenter(authRepo)
      : _loginUseCase = LoginUseCase(authRepo),
        _forgotPasswordUseCase = ForgotPasswordUseCase(authRepo);

  void doLogin(User user) => _loginUseCase.execute(
      _DoLoginObserver(this), UseCaseParams<User>(user));
  void doForgotPassword(String email) => _forgotPasswordUseCase.execute(
      _DoForgotPasswordObserver(this), UseCaseParams<String>(email));

  @override
  void dispose() {
    _loginUseCase.dispose();
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

class _DoForgotPasswordObserver extends Observer<UseCaseResponse<bool>> {
  LoginPresenter presenter;

  _DoForgotPasswordObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.forgotPasswordOnError(e);
  }

  @override
  void onNext(response) {
    presenter.forgotPasswordOnNext(response!.response);
  }
}