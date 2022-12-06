
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/pages/login/login_controller.dart';
import 'package:rapor_lc/app/utils/constants.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field.dart';
import 'package:rapor_lc/app/widgets/form_field/form_input_field_radios.dart';
import 'package:rapor_lc/data/repositories/auth_repo_impl.dart';

import 'dart:io' show Platform;

import 'package:rapor_lc/data/repositories/setting_repo_impl.dart';

class LoginPage extends View {
  final String? errorMessage;

  LoginPage({Key? key, this.errorMessage}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageView();
}

class LoginPageView extends ViewState<LoginPage, LoginController> {
  LoginPageView()
      : super(LoginController(AuthenticationRepositoryImpl(), SettingRepositoryImpl()));

  final _duration = const Duration(milliseconds: 400);
  final _loginFormKey = GlobalKey<FormState>();
  //final _forgotPassFormKey = GlobalKey<FormState>();
  final _emailCon = TextEditingController();
  final _passwordCon = TextEditingController();
  //final _forgotPassEmailCon = TextEditingController();
  bool _hidePass = true;

  @override
  Widget get view => Scaffold(
    key: globalKey,
    body: Container(
      decoration: const BoxDecoration(
        //color: Colors.blue,
        image: DecorationImage(
          image: AssetImage(Resources.background),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Card(
          child: ControlledWidgetBuilder<LoginController>(
              builder: (context, controller) {
                return SingleChildScrollView(
                  child: Container(
                    width: 400.0,
                    height: 570.0,
                    padding: const EdgeInsets.all(32.0),
                    child: Stack(
                      children: [
                        IgnorePointer(
                          ignoring: controller.isLoading,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Image.asset(
                                  Resources.logo,
                                  height: 180.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    IgnorePointer(
                                      ignoring: controller.formState != LoginFormState.login,
                                      child: AnimatedOpacity(
                                        opacity: controller.formState == LoginFormState.login ? 1 : 0,
                                        duration: _duration,
                                        child: _loginForm(controller),
                                      ),
                                    ),
                                    /*IgnorePointer(
                                      ignoring: controller.formState != LoginFormState.forgotPass,
                                      child: AnimatedOpacity(
                                        opacity: controller.formState == LoginFormState.forgotPass ? 1 : 0,
                                        duration: _duration,
                                        child: _forgotPasswordForm(controller),
                                      ),
                                    ),*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IgnorePointer(
                          ignoring: !controller.isLoading,
                          child: _loadingView(controller),
                        ),
                      ],
                    ),
                  ),
                );
            }
          ),
        ),
      ),
    ),
  );

  Form _loginForm(LoginController controller) => Form(
    key: _loginFormKey,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormInputFieldRadios(
          label: 'Login As',
          value: controller.loginAs.index,
          onChanged: controller.setLoginAs,
          contents: [
            'Teacher',
            if (Platform.isWindows || kIsWeb) 'Admin',
          ],
        ),
        FormInputField(
          label: 'Email',
          controller: _emailCon,
        ),
        FormInputField(
          label: 'Password',
          controller: _passwordCon,
          isObscured: _hidePass,
          isPassword: true,
          onTap: () {
            setState(() {
              _hidePass = !_hidePass;
            });
          },
        ),
        /*Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Forgot Password?'),
            TextButton(
              onPressed: controller.toForgotPassword,
              child: Text(
                'Press here',
                style: TextStyle(
                  color: Colors.blue.shade800,
                ),
              ),
            ),
          ],
        ),*/
        if (widget.errorMessage!=null) Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(widget.errorMessage!, style: TextStyle(color: Colors.redAccent),),
        ),
        if (widget.errorMessage==null) const SizedBox(),
        ElevatedButton(
          onPressed: () => controller.doLogin(_loginFormKey, _emailCon.text, _passwordCon.text),
          child: const Text('Login'),
        ),
      ],
    ),
  );

  /*Form _forgotPasswordForm(LoginController controller) => Form(
    key: _forgotPassFormKey,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: BackButton(
            onPressed: controller.toLogin,
          ),
        ),
        FormInputField(
          label: 'Email',
          controller: _forgotPassEmailCon,
        ),
        ElevatedButton(
          onPressed: () => controller.doForgotPassword(
            _forgotPassFormKey, _forgotPassEmailCon.text,
          ),
          child: const Text('Reset Password'),
        ),
        const SizedBox(height: 0.0),
        const Center(child: Text('New password will be send to your email.')),
        const SizedBox(height: 30.0),
      ],
    ),
  );*/

  Widget _loadingView(LoginController controller) => AnimatedOpacity(
    opacity: controller.isLoading ? 1 : 0,
    duration: _duration,
    child: Container(
      color: Colors.white.withOpacity(.7),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    ),
  );
}