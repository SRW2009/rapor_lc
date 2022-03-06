
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/user/create_user.dart';
import 'package:rapor_lc/domain/usecases/user/delete_user.dart';
import 'package:rapor_lc/domain/usecases/user/get_user_list.dart';
import 'package:rapor_lc/domain/usecases/user/update_user.dart';

class AdminHomeUserPresenter extends Presenter {
  late Function(List<User>) getUserList;
  late Function(RequestState) getUserListState;
  late Function(RequestStatus) createUserStatus;
  late Function(RequestStatus) updateUserStatus;
  late Function(RequestStatus) deleteUserStatus;

  final GetUserListUseCase _getUserListAdminUseCase;
  final CreateUserUseCase _createUserUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  final DeleteUserUseCase _deleteUserUseCase;
  AdminHomeUserPresenter(userRepo)
      : _getUserListAdminUseCase = GetUserListUseCase(userRepo),
        _createUserUseCase = CreateUserUseCase(userRepo),
        _updateUserUseCase = UpdateUserUseCase(userRepo),
        _deleteUserUseCase = DeleteUserUseCase(userRepo);

  void doGetUserList() {
    getUserListState(RequestState.loading);
    _getUserListAdminUseCase.execute(_GetUserListObserver(this), UseCaseParams<int?>(null));
  }
  void doCreateUser(User santri) {
    createUserStatus(RequestStatus.loading);
    _createUserUseCase.execute(_CreateUserObserver(this), UseCaseParams<User>(santri));
  }
  void doUpdateUser(User santri) {
    updateUserStatus(RequestStatus.loading);
    _updateUserUseCase.execute(_UpdateUserObserver(this), UseCaseParams<User>(santri));
  }
  void doDeleteUser(List<String> ids) {
    updateUserStatus(RequestStatus.loading);
    _deleteUserUseCase.execute(_DeleteUserObserver(this), UseCaseParams<List<String>>(ids));
  }

  @override
  void dispose() {
    _getUserListAdminUseCase.dispose();
    _createUserUseCase.dispose();
    _updateUserUseCase.dispose();
    _deleteUserUseCase.dispose();
  }
}

class _GetUserListObserver extends Observer<UseCaseResponse<List<User>>> {
  final AdminHomeUserPresenter _presenter;

  _GetUserListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getUserListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<User>>? response) {
    final list = response!.response;
    _presenter.getUserList(list);
    _presenter.getUserListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}

class _CreateUserObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeUserPresenter _presenter;

  _CreateUserObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.createUserStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.createUserStatus(response!.response);
}

class _UpdateUserObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeUserPresenter _presenter;

  _UpdateUserObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.updateUserStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.updateUserStatus(response!.response);
}

class _DeleteUserObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeUserPresenter _presenter;

  _DeleteUserObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.deleteUserStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.deleteUserStatus(response!.response);
}