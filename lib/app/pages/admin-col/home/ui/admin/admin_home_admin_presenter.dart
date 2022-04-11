
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/admin.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/admin/create_admin.dart';
import 'package:rapor_lc/domain/usecases/admin/delete_admin.dart';
import 'package:rapor_lc/domain/usecases/admin/get_admin_list.dart';
import 'package:rapor_lc/domain/usecases/admin/update_admin.dart';

class AdminHomeAdminPresenter extends Presenter {
  late Function(List<Admin>) getAdminList;
  late Function(RequestState) getAdminListState;
  late Function(RequestStatus) createAdminStatus;
  late Function(RequestStatus) updateAdminStatus;
  late Function(RequestStatus) deleteAdminStatus;

  final GetAdminListUseCase _getAdminListAdminUseCase;
  final CreateAdminUseCase _createAdminUseCase;
  final UpdateAdminUseCase _updateAdminUseCase;
  final DeleteAdminUseCase _deleteAdminUseCase;
  AdminHomeAdminPresenter(userRepo)
      : _getAdminListAdminUseCase = GetAdminListUseCase(userRepo),
        _createAdminUseCase = CreateAdminUseCase(userRepo),
        _updateAdminUseCase = UpdateAdminUseCase(userRepo),
        _deleteAdminUseCase = DeleteAdminUseCase(userRepo);

  void doGetAdminList() {
    getAdminListState(RequestState.loading);
    _getAdminListAdminUseCase.execute(_GetAdminListObserver(this), UseCaseParams<int?>(null));
  }
  void doCreateAdmin(Admin admin) {
    createAdminStatus(RequestStatus.loading);
    _createAdminUseCase.execute(_CreateAdminObserver(this), UseCaseParams<Admin>(admin));
  }
  void doUpdateAdmin(Admin admin) {
    updateAdminStatus(RequestStatus.loading);
    _updateAdminUseCase.execute(_UpdateAdminObserver(this), UseCaseParams<Admin>(admin));
  }
  void doDeleteAdmin(List<String> ids) {
    updateAdminStatus(RequestStatus.loading);
    _deleteAdminUseCase.execute(_DeleteAdminObserver(this), UseCaseParams<List<String>>(ids));
  }

  @override
  void dispose() {
    _getAdminListAdminUseCase.dispose();
    _createAdminUseCase.dispose();
    _updateAdminUseCase.dispose();
    _deleteAdminUseCase.dispose();
  }
}

class _GetAdminListObserver extends Observer<UseCaseResponse<List<Admin>>> {
  final AdminHomeAdminPresenter _presenter;

  _GetAdminListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getAdminListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<Admin>>? response) {
    final list = response!.response;
    _presenter.getAdminList(list);
    _presenter.getAdminListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}

class _CreateAdminObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeAdminPresenter _presenter;

  _CreateAdminObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.createAdminStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.createAdminStatus(response!.response);
}

class _UpdateAdminObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeAdminPresenter _presenter;

  _UpdateAdminObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.updateAdminStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.updateAdminStatus(response!.response);
}

class _DeleteAdminObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeAdminPresenter _presenter;

  _DeleteAdminObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.deleteAdminStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.deleteAdminStatus(response!.response);
}