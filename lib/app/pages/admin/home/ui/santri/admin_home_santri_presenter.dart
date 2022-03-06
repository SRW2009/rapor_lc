
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/santri/create_santri.dart';
import 'package:rapor_lc/domain/usecases/santri/delete_santri.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list_admin.dart';
import 'package:rapor_lc/domain/usecases/santri/update_santri.dart';
import 'package:rapor_lc/domain/entities/user.dart';
import 'package:rapor_lc/domain/usecases/user/get_user_list.dart';

class AdminHomeSantriPresenter extends Presenter {
  late Function(List<Santri>) getSantriList;
  late Function(RequestState) getSantriListState;
  late Function(RequestStatus) createSantriStatus;
  late Function(RequestStatus) updateSantriStatus;
  late Function(RequestStatus) deleteSantriStatus;

  final GetSantriListAdminUseCase _getSantriListAdminUseCase;
  final CreateSantriUseCase _createSantriUseCase;
  final UpdateSantriUseCase _updateSantriUseCase;
  final DeleteSantriUseCase _deleteSantriUseCase;
  final GetUserListUseCase _getUserListUseCase;
  AdminHomeSantriPresenter(authRepo, userRepo)
      : _getSantriListAdminUseCase = GetSantriListAdminUseCase(authRepo),
        _createSantriUseCase = CreateSantriUseCase(authRepo),
        _updateSantriUseCase = UpdateSantriUseCase(authRepo),
        _deleteSantriUseCase = DeleteSantriUseCase(authRepo),
        _getUserListUseCase = GetUserListUseCase(userRepo);

  void doGetSantriList() {
    getSantriListState(RequestState.loading);
    _getSantriListAdminUseCase.execute(_GetSantriListObserver(this));
  }
  void doCreateSantri(Santri santri) {
    createSantriStatus(RequestStatus.loading);
    _createSantriUseCase.execute(_CreateSantriObserver(this), UseCaseParams<Santri>(santri));
  }
  void doUpdateSantri(Santri santri) {
    updateSantriStatus(RequestStatus.loading);
    _updateSantriUseCase.execute(_UpdateSantriObserver(this), UseCaseParams<Santri>(santri));
  }
  void doDeleteSantri(List<String> nis) {
    updateSantriStatus(RequestStatus.loading);
    _deleteSantriUseCase.execute(_DeleteSantriObserver(this), UseCaseParams<List<String>>(nis));
  }
  Future<List<User>> futureGetTeacherList(int status) {
    return _getUserListUseCase.repository.getUserListAdmin(status);
  }

  @override
  void dispose() {
    _getSantriListAdminUseCase.dispose();
    _createSantriUseCase.dispose();
    _updateSantriUseCase.dispose();
    _deleteSantriUseCase.dispose();
    _getUserListUseCase.dispose();
  }
}

class _GetSantriListObserver extends Observer<UseCaseResponse<List<Santri>>> {
  final AdminHomeSantriPresenter _presenter;

  _GetSantriListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getSantriListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<Santri>>? response) {
    final list = response!.response;
    _presenter.getSantriList(list);
    _presenter.getSantriListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}

class _CreateSantriObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeSantriPresenter _presenter;

  _CreateSantriObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.createSantriStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.createSantriStatus(response!.response);
}

class _UpdateSantriObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeSantriPresenter _presenter;

  _UpdateSantriObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.updateSantriStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.updateSantriStatus(response!.response);
}

class _DeleteSantriObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeSantriPresenter _presenter;

  _DeleteSantriObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.deleteSantriStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.deleteSantriStatus(response!.response);
}