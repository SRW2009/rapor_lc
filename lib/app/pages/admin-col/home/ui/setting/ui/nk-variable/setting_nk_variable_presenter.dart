
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/subclasses/lazy_presenter_observer.dart';
import 'package:rapor_lc/app/utils/loaded_settings.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/divisi/get_divisi_list.dart';
import 'package:rapor_lc/domain/usecases/mapel/create_mapel.dart';
import 'package:rapor_lc/domain/usecases/mapel/delete_mapel.dart';
import 'package:rapor_lc/domain/usecases/mapel/get_nk_variables.dart';
import 'package:rapor_lc/domain/usecases/mapel/update_mapel.dart';

class SettingNKVariablePresenter extends Presenter {
  late Function(List<MataPelajaran>) getNKVariableList;
  late Function(RequestState) getNKVariableListState;
  late Function(RequestStatus) createNKVariableStatus;
  late Function(RequestStatus) updateNKVariableStatus;
  late Function(RequestStatus) deleteNKVariableStatus;
  late Function(RequestState) getDivisiKesantrianState;

  final GetNKVariablesUseCase _getNKVariableListUseCase;
  final CreateMataPelajaranUseCase _createNKVariableUseCase;
  final UpdateMataPelajaranUseCase _updateNKVariableUseCase;
  final DeleteMataPelajaranUseCase _deleteNKVariableUseCase;
  final GetDivisiListUseCase _getDivisiListUseCase;
  SettingNKVariablePresenter(mapelRepo, divisiRepo)
      : _getNKVariableListUseCase = GetNKVariablesUseCase(mapelRepo),
        _createNKVariableUseCase = CreateMataPelajaranUseCase(mapelRepo),
        _updateNKVariableUseCase = UpdateMataPelajaranUseCase(mapelRepo),
        _deleteNKVariableUseCase = DeleteMataPelajaranUseCase(mapelRepo),
        _getDivisiListUseCase = GetDivisiListUseCase(divisiRepo);

  void doGetNKVariableList() {
    getNKVariableListState(RequestState.loading);
    _getNKVariableListUseCase.execute(_GetNKVariableListObserver(this), UseCaseParams<int?>(null));
  }
  void doCreateNKVariable(MataPelajaran mapel) {
    createNKVariableStatus(RequestStatus.loading);
    _createNKVariableUseCase.execute(LazyPresenterObserver(createNKVariableStatus), UseCaseParams<MataPelajaran>(mapel));
  }
  void doUpdateNKVariable(MataPelajaran mapel) {
    updateNKVariableStatus(RequestStatus.loading);
    _updateNKVariableUseCase.execute(LazyPresenterObserver(updateNKVariableStatus), UseCaseParams<MataPelajaran>(mapel));
  }
  void doDeleteNKVariable(List<String> ids) {
    deleteNKVariableStatus(RequestStatus.loading);
    _deleteNKVariableUseCase.execute(LazyPresenterObserver(deleteNKVariableStatus), UseCaseParams<List<String>>(ids));
  }
  void doGetDivisiKesantrian() {
    getNKVariableListState(RequestState.loading);
    _getDivisiListUseCase.execute(_GetDivisiKesantrianListObserver(this));
  }

  @override
  void dispose() {
    _getNKVariableListUseCase.dispose();
    _createNKVariableUseCase.dispose();
    _updateNKVariableUseCase.dispose();
    _deleteNKVariableUseCase.dispose();
    _getDivisiListUseCase.dispose();
  }
}

class _GetNKVariableListObserver extends Observer<UseCaseResponse<List<MataPelajaran>>> {
  final SettingNKVariablePresenter _presenter;

  _GetNKVariableListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getNKVariableListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<MataPelajaran>>? response) {
    final list = response!.response;
    _presenter.getNKVariableList(list);
    _presenter.getNKVariableListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}

class _GetDivisiKesantrianListObserver implements Observer<UseCaseResponse<List<Divisi>>> {
  final SettingNKVariablePresenter _presenter;

  _GetDivisiKesantrianListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getDivisiKesantrianState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<Divisi>>? response) {
    _presenter.getDivisiKesantrianState(
        (LoadedSettings.divisiKesantrian != null)
        ? RequestState.loaded
        : RequestState.none);
  }
}