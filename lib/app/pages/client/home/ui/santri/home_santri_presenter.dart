
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list.dart';
import 'package:rapor_lc/domain/usecases/santri/create_santri.dart';
import 'package:rapor_lc/domain/usecases/santri/delete_santri.dart';
import 'package:rapor_lc/domain/usecases/santri/update_santri.dart';

class HomeSantriPresenter extends Presenter {
  late Function(List<Santri>) getSantriList;
  late Function(RequestState) getSantriListState;
  late Function(RequestStatus) createSantriStatus;
  late Function(RequestStatus) updateSantriStatus;
  late Function(RequestStatus) deleteSantriStatus;

  final GetSantriListUseCase _getSantriListAdminUseCase;
  final CreateSantriUseCase _createSantriUseCase;
  final UpdateSantriUseCase _updateSantriUseCase;
  final DeleteSantriUseCase _deleteSantriUseCase;
  HomeSantriPresenter(santriRepo)
      : _getSantriListAdminUseCase = GetSantriListUseCase(santriRepo),
        _createSantriUseCase = CreateSantriUseCase(santriRepo),
        _updateSantriUseCase = UpdateSantriUseCase(santriRepo),
        _deleteSantriUseCase = DeleteSantriUseCase(santriRepo);

  void doGetSantriList() {
    getSantriListState(RequestState.loading);
    _getSantriListAdminUseCase.execute(_GetSantriListObserver(this), UseCaseParams<int?>(null));
  }
  void doCreateSantri(Santri santri) {
    createSantriStatus(RequestStatus.loading);
    _createSantriUseCase.execute(_CreateSantriObserver(this), UseCaseParams<Santri>(santri));
  }
  void doUpdateSantri(Santri santri) {
    updateSantriStatus(RequestStatus.loading);
    _updateSantriUseCase.execute(_UpdateSantriObserver(this), UseCaseParams<Santri>(santri));
  }
  void doDeleteSantri(List<String> ids) {
    updateSantriStatus(RequestStatus.loading);
    _deleteSantriUseCase.execute(_DeleteSantriObserver(this), UseCaseParams<List<String>>(ids));
  }

  @override
  void dispose() {
    _getSantriListAdminUseCase.dispose();
    _createSantriUseCase.dispose();
    _updateSantriUseCase.dispose();
    _deleteSantriUseCase.dispose();
  }
}

class _GetSantriListObserver extends Observer<UseCaseResponse<List<Santri>>> {
  final HomeSantriPresenter _presenter;

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
  final HomeSantriPresenter _presenter;

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
  final HomeSantriPresenter _presenter;

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
  final HomeSantriPresenter _presenter;

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