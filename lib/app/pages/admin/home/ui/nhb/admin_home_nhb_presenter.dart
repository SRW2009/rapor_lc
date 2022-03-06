
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/mapel/get_mapel_list_admin.dart';
import 'package:rapor_lc/domain/usecases/nhb/create_nhb.dart';
import 'package:rapor_lc/domain/usecases/nhb/delete_nhb.dart';
import 'package:rapor_lc/domain/usecases/nhb/get_nhb_list_admin.dart';
import 'package:rapor_lc/domain/usecases/nhb/update_nhb.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list_admin.dart';

class AdminHomeNHBPresenter extends Presenter {
  late Function(List<NHB>) getNHBList;
  late Function(RequestState) getNHBListState;
  late Function(RequestStatus) createNHBStatus;
  late Function(RequestStatus) updateNHBStatus;
  late Function(RequestStatus) deleteNHBStatus;

  final GetNHBListAdminUseCase _getNHBListAdminUseCase;
  final CreateNHBUseCase _createNHBUseCase;
  final UpdateNHBUseCase _updateNHBUseCase;
  final DeleteNHBUseCase _deleteNHBUseCase;
  final GetSantriListAdminUseCase _getSantriListAdminUseCase;
  final GetMataPelajaranListAdminUseCase _getMataPelajaranListAdminUseCase;
  AdminHomeNHBPresenter(nhbRepo, santriRepo, mapelRepo)
      : _getNHBListAdminUseCase = GetNHBListAdminUseCase(nhbRepo),
        _createNHBUseCase = CreateNHBUseCase(nhbRepo),
        _updateNHBUseCase = UpdateNHBUseCase(nhbRepo),
        _deleteNHBUseCase = DeleteNHBUseCase(nhbRepo),
        _getSantriListAdminUseCase = GetSantriListAdminUseCase(santriRepo),
        _getMataPelajaranListAdminUseCase = GetMataPelajaranListAdminUseCase(mapelRepo);

  void doGetNHBList() {
    getNHBListState(RequestState.loading);
    _getNHBListAdminUseCase.execute(_GetNHBListObserver(this));
  }
  void doCreateNHB(NHB santri) {
    createNHBStatus(RequestStatus.loading);
    _createNHBUseCase.execute(_CreateNHBObserver(this), UseCaseParams<NHB>(santri));
  }
  void doUpdateNHB(NHB santri) {
    updateNHBStatus(RequestStatus.loading);
    _updateNHBUseCase.execute(_UpdateNHBObserver(this), UseCaseParams<NHB>(santri));
  }
  void doDeleteNHB(List<String> ids) {
    updateNHBStatus(RequestStatus.loading);
    _deleteNHBUseCase.execute(_DeleteNHBObserver(this), UseCaseParams<List<String>>(ids));
  }
  Future<List<Santri>> futureGetSantriList() {
    return _getSantriListAdminUseCase.repository.getSantriListAdmin();
  }
  Future<List<MataPelajaran>> futureGetMapelList() {
    return _getMataPelajaranListAdminUseCase.repository.getMataPelajaranListAdmin();
  }

  @override
  void dispose() {
    _getNHBListAdminUseCase.dispose();
    _createNHBUseCase.dispose();
    _updateNHBUseCase.dispose();
    _deleteNHBUseCase.dispose();
    _getSantriListAdminUseCase.dispose();
    _getMataPelajaranListAdminUseCase.dispose();
  }
}

class _GetNHBListObserver extends Observer<UseCaseResponse<List<NHB>>> {
  final AdminHomeNHBPresenter _presenter;

  _GetNHBListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getNHBListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<NHB>>? response) {
    final list = response!.response;
    _presenter.getNHBList(list);
    _presenter.getNHBListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}

class _CreateNHBObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeNHBPresenter _presenter;

  _CreateNHBObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.createNHBStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.createNHBStatus(response!.response);
}

class _UpdateNHBObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeNHBPresenter _presenter;

  _UpdateNHBObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.updateNHBStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.updateNHBStatus(response!.response);
}

class _DeleteNHBObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeNHBPresenter _presenter;

  _DeleteNHBObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.deleteNHBStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.deleteNHBStatus(response!.response);
}