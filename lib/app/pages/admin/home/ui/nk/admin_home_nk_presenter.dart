
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/nk/create_nk.dart';
import 'package:rapor_lc/domain/usecases/nk/delete_nk.dart';
import 'package:rapor_lc/domain/usecases/nk/get_nk_list_admin.dart';
import 'package:rapor_lc/domain/usecases/nk/update_nk.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list_admin.dart';

class AdminHomeNKPresenter extends Presenter {
  late Function(List<NK>) getNKList;
  late Function(RequestState) getNKListState;
  late Function(RequestStatus) createNKStatus;
  late Function(RequestStatus) updateNKStatus;
  late Function(RequestStatus) deleteNKStatus;

  final GetNKListAdminUseCase _getNKListAdminUseCase;
  final CreateNKUseCase _createNKUseCase;
  final UpdateNKUseCase _updateNKUseCase;
  final DeleteNKUseCase _deleteNKUseCase;
  final GetSantriListAdminUseCase _getSantriListAdminUseCase;
  AdminHomeNKPresenter(nkRepo, santriRepo)
      : _getNKListAdminUseCase = GetNKListAdminUseCase(nkRepo),
        _createNKUseCase = CreateNKUseCase(nkRepo),
        _updateNKUseCase = UpdateNKUseCase(nkRepo),
        _deleteNKUseCase = DeleteNKUseCase(nkRepo),
        _getSantriListAdminUseCase = GetSantriListAdminUseCase(santriRepo);

  void doGetNKList() {
    getNKListState(RequestState.loading);
    _getNKListAdminUseCase.execute(_GetNKListObserver(this));
  }
  void doCreateNK(NK santri) {
    createNKStatus(RequestStatus.loading);
    _createNKUseCase.execute(_CreateNKObserver(this), UseCaseParams<NK>(santri));
  }
  void doUpdateNK(NK santri) {
    updateNKStatus(RequestStatus.loading);
    _updateNKUseCase.execute(_UpdateNKObserver(this), UseCaseParams<NK>(santri));
  }
  void doDeleteNK(List<String> ids) {
    updateNKStatus(RequestStatus.loading);
    _deleteNKUseCase.execute(_DeleteNKObserver(this), UseCaseParams<List<String>>(ids));
  }
  Future<List<Santri>> futureGetSantriList() {
    return _getSantriListAdminUseCase.repository.getSantriListAdmin();
  }

  @override
  void dispose() {
    _getNKListAdminUseCase.dispose();
    _createNKUseCase.dispose();
    _updateNKUseCase.dispose();
    _deleteNKUseCase.dispose();
    _getSantriListAdminUseCase.dispose();
  }
}

class _GetNKListObserver extends Observer<UseCaseResponse<List<NK>>> {
  final AdminHomeNKPresenter _presenter;

  _GetNKListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getNKListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<NK>>? response) {
    final list = response!.response;
    _presenter.getNKList(list);
    _presenter.getNKListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}

class _CreateNKObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeNKPresenter _presenter;

  _CreateNKObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.createNKStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.createNKStatus(response!.response);
}

class _UpdateNKObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeNKPresenter _presenter;

  _UpdateNKObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.updateNKStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.updateNKStatus(response!.response);
}

class _DeleteNKObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeNKPresenter _presenter;

  _DeleteNKObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.deleteNKStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.deleteNKStatus(response!.response);
}