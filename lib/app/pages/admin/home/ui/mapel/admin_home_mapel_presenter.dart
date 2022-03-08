
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/divisi/get_divisi_list.dart';
import 'package:rapor_lc/domain/usecases/mapel/create_mapel.dart';
import 'package:rapor_lc/domain/usecases/mapel/delete_mapel.dart';
import 'package:rapor_lc/domain/usecases/mapel/get_mapel_list.dart';
import 'package:rapor_lc/domain/usecases/mapel/update_mapel.dart';

class AdminHomeMataPelajaranPresenter extends Presenter {
  late Function(List<MataPelajaran>) getMataPelajaranList;
  late Function(RequestState) getMataPelajaranListState;
  late Function(RequestStatus) createMataPelajaranStatus;
  late Function(RequestStatus) updateMataPelajaranStatus;
  late Function(RequestStatus) deleteMataPelajaranStatus;

  final GetMataPelajaranListUseCase _getMataPelajaranListAdminUseCase;
  final CreateMataPelajaranUseCase _createMataPelajaranUseCase;
  final UpdateMataPelajaranUseCase _updateMataPelajaranUseCase;
  final DeleteMataPelajaranUseCase _deleteMataPelajaranUseCase;
  final GetDivisiListUseCase _getDivisiListUseCase;
  AdminHomeMataPelajaranPresenter(mapelRepo, divisiRepo)
      : _getMataPelajaranListAdminUseCase = GetMataPelajaranListUseCase(mapelRepo),
        _createMataPelajaranUseCase = CreateMataPelajaranUseCase(mapelRepo),
        _updateMataPelajaranUseCase = UpdateMataPelajaranUseCase(mapelRepo),
        _deleteMataPelajaranUseCase = DeleteMataPelajaranUseCase(mapelRepo),
        _getDivisiListUseCase = GetDivisiListUseCase(divisiRepo);

  void doGetMataPelajaranList() {
    getMataPelajaranListState(RequestState.loading);
    _getMataPelajaranListAdminUseCase.execute(_GetMataPelajaranListObserver(this), UseCaseParams<int?>(null));
  }
  void doCreateMataPelajaran(MataPelajaran santri) {
    createMataPelajaranStatus(RequestStatus.loading);
    _createMataPelajaranUseCase.execute(_CreateMataPelajaranObserver(this), UseCaseParams<MataPelajaran>(santri));
  }
  void doUpdateMataPelajaran(MataPelajaran santri) {
    updateMataPelajaranStatus(RequestStatus.loading);
    _updateMataPelajaranUseCase.execute(_UpdateMataPelajaranObserver(this), UseCaseParams<MataPelajaran>(santri));
  }
  void doDeleteMataPelajaran(List<String> ids) {
    updateMataPelajaranStatus(RequestStatus.loading);
    _deleteMataPelajaranUseCase.execute(_DeleteMataPelajaranObserver(this), UseCaseParams<List<String>>(ids));
  }
  Future<List<Divisi>> futureGetDivisiList() {
    return _getDivisiListUseCase.repository.getDivisiList();
  }

  @override
  void dispose() {
    _getMataPelajaranListAdminUseCase.dispose();
    _createMataPelajaranUseCase.dispose();
    _updateMataPelajaranUseCase.dispose();
    _deleteMataPelajaranUseCase.dispose();
  }
}

class _GetMataPelajaranListObserver extends Observer<UseCaseResponse<List<MataPelajaran>>> {
  final AdminHomeMataPelajaranPresenter _presenter;

  _GetMataPelajaranListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getMataPelajaranListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<MataPelajaran>>? response) {
    final list = response!.response;
    _presenter.getMataPelajaranList(list);
    _presenter.getMataPelajaranListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}

class _CreateMataPelajaranObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeMataPelajaranPresenter _presenter;

  _CreateMataPelajaranObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.createMataPelajaranStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.createMataPelajaranStatus(response!.response);
}

class _UpdateMataPelajaranObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeMataPelajaranPresenter _presenter;

  _UpdateMataPelajaranObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.updateMataPelajaranStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.updateMataPelajaranStatus(response!.response);
}

class _DeleteMataPelajaranObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeMataPelajaranPresenter _presenter;

  _DeleteMataPelajaranObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.deleteMataPelajaranStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.deleteMataPelajaranStatus(response!.response);
}