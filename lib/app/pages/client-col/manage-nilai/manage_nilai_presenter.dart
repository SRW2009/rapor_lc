
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/nilai/create_nilai.dart';
import 'package:rapor_lc/domain/usecases/nilai/delete_nilai.dart';
import 'package:rapor_lc/domain/usecases/nilai/get_nilai_list.dart';
import 'package:rapor_lc/domain/usecases/nilai/update_nilai.dart';

class ManageNilaiPresenter extends Presenter {
  late Function(List<Nilai>) getNilaiList;
  late Function(RequestState) getNilaiListState;
  late Function(RequestStatus) createNilaiStatus;
  late Function(RequestStatus) updateNilaiStatus;
  late Function(RequestStatus) deleteNilaiStatus;
  
  final GetNilaiListUseCase _getNilaiListUseCase;
  final CreateNilaiUseCase _createNilaiUseCase;
  final UpdateNilaiUseCase _updateNilaiUseCase;
  final DeleteNilaiUseCase _deleteNilaiUseCase;
  ManageNilaiPresenter(nilaiRepo) 
      : _getNilaiListUseCase = GetNilaiListUseCase(nilaiRepo),
        _createNilaiUseCase = CreateNilaiUseCase(nilaiRepo),
        _updateNilaiUseCase = UpdateNilaiUseCase(nilaiRepo),
        _deleteNilaiUseCase = DeleteNilaiUseCase(nilaiRepo);
  
  void doGetNilaiList() {
    // TODO: put param if query is implemented in request `get my students nilai`
    getNilaiListState(RequestState.loading);
    _getNilaiListUseCase.execute(_GetNilaiListObserver(this));
  }
  void doCreateNilai(Nilai item) {
    createNilaiStatus(RequestStatus.loading);
    _createNilaiUseCase.execute(_CreateNilaiObserver(this), UseCaseParams(item));
  }
  void doUpdateNilai(Nilai item) {
    updateNilaiStatus(RequestStatus.loading);
    _updateNilaiUseCase.execute(_UpdateNilaiObserver(this), UseCaseParams(item));
  }
  void doDeleteNilai(List<String> ids) {
    deleteNilaiStatus(RequestStatus.loading);
    _deleteNilaiUseCase.execute(_DeleteNilaiObserver(this), UseCaseParams(ids));
  }

  @override
  void dispose() {
    _getNilaiListUseCase.dispose();
    _createNilaiUseCase.dispose();
    _updateNilaiUseCase.dispose();
    _deleteNilaiUseCase.dispose();
  }
}

class _GetNilaiListObserver extends Observer<UseCaseResponse<List<Nilai>>> {
  final ManageNilaiPresenter _presenter;

  _GetNilaiListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getNilaiListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<Nilai>>? response) {
    final list = response!.response;
    _presenter.getNilaiList(list);
    _presenter.getNilaiListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}

class _CreateNilaiObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final ManageNilaiPresenter _presenter;

  _CreateNilaiObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.createNilaiStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.createNilaiStatus(response!.response);
}

class _UpdateNilaiObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final ManageNilaiPresenter _presenter;

  _UpdateNilaiObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.updateNilaiStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.updateNilaiStatus(response!.response);
}

class _DeleteNilaiObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final ManageNilaiPresenter _presenter;

  _DeleteNilaiObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.deleteNilaiStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.deleteNilaiStatus(response!.response);
}