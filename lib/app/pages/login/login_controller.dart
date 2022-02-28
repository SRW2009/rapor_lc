
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/login/login_presenter.dart';

class LoginController extends Controller {
  final LoginPresenter _loginPresenter;

  LoginController(authRepo)
      : _loginPresenter = LoginPresenter(authRepo),
        super();

  @override
  void initListeners() {
    _loginPresenter.authOnNext = (isAuth) {

    };
  }

}