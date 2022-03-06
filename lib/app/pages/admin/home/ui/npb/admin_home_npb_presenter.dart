
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/mapel/get_mapel_list.dart';
import 'package:rapor_lc/domain/usecases/npb/create_npb.dart';
import 'package:rapor_lc/domain/usecases/npb/delete_npb.dart';
import 'package:rapor_lc/domain/usecases/npb/get_npb_list_admin.dart';
import 'package:rapor_lc/domain/usecases/npb/update_npb.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list_admin.dart';

class AdminHomeNPBPresenter extends Presenter {
  late Function(List<NPB>) getNPBList;
  late Function(RequestState) getNPBListState;
  late Function(RequestStatus) createNPBStatus;
  late Function(RequestStatus) updateNPBStatus;
  late Function(RequestStatus) deleteNPBStatus;

  final GetNPBListAdminUseCase _getNPBListAdminUseCase;
  final CreateNPBUseCase _createNPBUseCase;
  final UpdateNPBUseCase _updateNPBUseCase;
  final DeleteNPBUseCase _deleteNPBUseCase;
  final GetSantriListAdminUseCase _getSantriListAdminUseCase;
  final GetMataPelajaranListUseCase _getMataPelajaranListAdminUseCase;
  AdminHomeNPBPresenter(npbRepo, santriRepo, mapelRepo)
      : _getNPBListAdminUseCase = GetNPBListAdminUseCase(npbRepo),
        _createNPBUseCase = CreateNPBUseCase(npbRepo),
        _updateNPBUseCase = UpdateNPBUseCase(npbRepo),
        _deleteNPBUseCase = DeleteNPBUseCase(npbRepo),
        _getSantriListAdminUseCase = GetSantriListAdminUseCase(santriRepo),
        _getMataPelajaranListAdminUseCase = GetMataPelajaranListUseCase(mapelRepo);

  void doGetNPBList() {
    getNPBListState(RequestState.loading);
    _getNPBListAdminUseCase.execute(_GetNPBListObserver(this));
  }
  void doCreateNPB(NPB santri) {
    createNPBStatus(RequestStatus.loading);
    _createNPBUseCase.execute(_CreateNPBObserver(this), UseCaseParams<NPB>(santri));
  }
  void doUpdateNPB(NPB santri) {
    updateNPBStatus(RequestStatus.loading);
    _updateNPBUseCase.execute(_UpdateNPBObserver(this), UseCaseParams<NPB>(santri));
  }
  void doDeleteNPB(List<String> ids) {
    updateNPBStatus(RequestStatus.loading);
    _deleteNPBUseCase.execute(_DeleteNPBObserver(this), UseCaseParams<List<String>>(ids));
  }
  Future<List<Santri>> futureGetSantriList() {
    return _getSantriListAdminUseCase.repository.getSantriListAdmin();
  }
  Future<List<MataPelajaran>> futureGetMapelList() {
    return _getMataPelajaranListAdminUseCase.repository.getMataPelajaranList();
  }

  @override
  void dispose() {
    _getNPBListAdminUseCase.dispose();
    _createNPBUseCase.dispose();
    _updateNPBUseCase.dispose();
    _deleteNPBUseCase.dispose();
    _getSantriListAdminUseCase.dispose();
    _getMataPelajaranListAdminUseCase.dispose();
  }
}

class _GetNPBListObserver extends Observer<UseCaseResponse<List<NPB>>> {
  final AdminHomeNPBPresenter _presenter;

  _GetNPBListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getNPBListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<NPB>>? response) {
    final list = response!.response;
    _presenter.getNPBList(list);
    _presenter.getNPBListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}

class _CreateNPBObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeNPBPresenter _presenter;

  _CreateNPBObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.createNPBStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.createNPBStatus(response!.response);
}

class _UpdateNPBObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeNPBPresenter _presenter;

  _UpdateNPBObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.updateNPBStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.updateNPBStatus(response!.response);
}

class _DeleteNPBObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeNPBPresenter _presenter;

  _DeleteNPBObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.deleteNPBStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.deleteNPBStatus(response!.response);
}