
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/usecases/auth/forgot_password.dart';
import 'package:rapor_lc/domain/usecases/auth/login_admin.dart';
import 'package:rapor_lc/domain/usecases/auth/login_teacher.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class LoginPresenter extends Presenter {
  late Function(int) authOnNext;
  late Function(dynamic) authOnError;
  late Function(bool) forgotPasswordOnNext;
  late Function(dynamic) forgotPasswordOnError;

  final LoginAdminUseCase _loginAdminUseCase;
  final LoginTeacherUseCase _loginTeacherUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  LoginPresenter(authRepo)
      : _loginAdminUseCase = LoginAdminUseCase(authRepo),
        _loginTeacherUseCase = LoginTeacherUseCase(authRepo),
        _forgotPasswordUseCase = ForgotPasswordUseCase(authRepo);

  void doLoginTeacher(Teacher user) => _loginTeacherUseCase.execute(
      _DoLoginObserver(this), UseCaseParams(user));
  void doLoginAdmin(Admin user) => _loginAdminUseCase.execute(
      _DoLoginObserver(this), UseCaseParams(user));
  void doForgotPassword(String email) => _forgotPasswordUseCase.execute(
      _DoForgotPasswordObserver(this), UseCaseParams<String>(email));

  @override
  void dispose() {
    _loginAdminUseCase.dispose();
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