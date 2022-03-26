
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/divisi/get_divisi_list.dart';
import 'package:rapor_lc/domain/usecases/divisi/create_divisi.dart';
import 'package:rapor_lc/domain/usecases/divisi/delete_divisi.dart';
import 'package:rapor_lc/domain/usecases/divisi/update_divisi.dart';

class AdminHomeDivisiPresenter extends Presenter {
  late Function(List<Divisi>) getDivisiList;
  late Function(RequestState) getDivisiListState;
  late Function(RequestStatus) createDivisiStatus;
  late Function(RequestStatus) updateDivisiStatus;
  late Function(RequestStatus) deleteDivisiStatus;

  final GetDivisiListUseCase _getDivisiListAdminUseCase;
  final CreateDivisiUseCase _createDivisiUseCase;
  final UpdateDivisiUseCase _updateDivisiUseCase;
  final DeleteDivisiUseCase _deleteDivisiUseCase;
  AdminHomeDivisiPresenter(divisiRepo)
      : _getDivisiListAdminUseCase = GetDivisiListUseCase(divisiRepo),
        _createDivisiUseCase = CreateDivisiUseCase(divisiRepo),
        _updateDivisiUseCase = UpdateDivisiUseCase(divisiRepo),
        _deleteDivisiUseCase = DeleteDivisiUseCase(divisiRepo);

  void doGetDivisiList() {
    getDivisiListState(RequestState.loading);
    _getDivisiListAdminUseCase.execute(_GetDivisiListObserver(this), UseCaseParams<int?>(null));
  }
  void doCreateDivisi(Divisi santri) {
    createDivisiStatus(RequestStatus.loading);
    _createDivisiUseCase.execute(_CreateDivisiObserver(this), UseCaseParams<Divisi>(santri));
  }
  void doUpdateDivisi(Divisi santri) {
    updateDivisiStatus(RequestStatus.loading);
    _updateDivisiUseCase.execute(_UpdateDivisiObserver(this), UseCaseParams<Divisi>(santri));
  }
  void doDeleteDivisi(List<String> ids) {
    updateDivisiStatus(RequestStatus.loading);
    _deleteDivisiUseCase.execute(_DeleteDivisiObserver(this), UseCaseParams<List<String>>(ids));
  }

  @override
  void dispose() {
    _getDivisiListAdminUseCase.dispose();
    _createDivisiUseCase.dispose();
    _updateDivisiUseCase.dispose();
    _deleteDivisiUseCase.dispose();
  }
}

class _GetDivisiListObserver extends Observer<UseCaseResponse<List<Divisi>>> {
  final AdminHomeDivisiPresenter _presenter;

  _GetDivisiListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getDivisiListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<Divisi>>? response) {
    final list = response!.response;
    _presenter.getDivisiList(list);
    _presenter.getDivisiListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}

class _CreateDivisiObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeDivisiPresenter _presenter;

  _CreateDivisiObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.createDivisiStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.createDivisiStatus(response!.response);
}

class _UpdateDivisiObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeDivisiPresenter _presenter;

  _UpdateDivisiObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.updateDivisiStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.updateDivisiStatus(response!.response);
}

class _DeleteDivisiObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeDivisiPresenter _presenter;

  _DeleteDivisiObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.deleteDivisiStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.deleteDivisiStatus(response!.response);
}