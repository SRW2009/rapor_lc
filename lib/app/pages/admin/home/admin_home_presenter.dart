
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/usecases/auth/get_current_user.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/nhb/get_nhb_list_admin.dart';
import 'package:rapor_lc/domain/usecases/nk/get_nk_list_admin.dart';
import 'package:rapor_lc/domain/usecases/npb/get_npb_list_admin.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list_admin.dart';

class AdminHomePresenter extends Presenter {
  late Function(User) getCurrentUserOnNext;
  late Function(dynamic) getCurrentUserOnError;

  final GetCurrentUserUseCase _getCurrentUserUseCase;
  AdminHomePresenter(authRepository)
      : _getCurrentUserUseCase = GetCurrentUserUseCase(authRepository);

  void doGetCurrentUser() => _getCurrentUserUseCase.execute(_GetCurrentUserObserver(this));

  @override
  void dispose() {
    _getCurrentUserUseCase.dispose();
  }
}

class _GetCurrentUserObserver extends Observer<UseCaseResponse<User>> {
  final AdminHomePresenter presenter;

  _GetCurrentUserObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.getCurrentUserOnError(e);
  }

  @override
  void onNext(UseCaseResponse<User>? response) {
    presenter.getCurrentUserOnNext(response!.response);
  }
}