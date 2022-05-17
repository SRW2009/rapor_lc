
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/nilai/get_nilai_list.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list.dart';

class HomeRecordPresenter extends Presenter {
  late Function(List<Santri>) getSantriList;
  late Function(RequestState) getSantriListState;
  late Function(List<Nilai>) getNilaiList;
  late Function(RequestState) getNilaiListState;

  final GetSantriListUseCase _getSantriListUseCase;
  final GetNilaiListUseCase _getNilaiListUseCase;
  HomeRecordPresenter(santriRepo, nilaiRepo)
      : _getSantriListUseCase = GetSantriListUseCase(santriRepo),
        _getNilaiListUseCase = GetNilaiListUseCase(nilaiRepo);

  void doGetSantriList() {
    getSantriListState(RequestState.loading);
    _getSantriListUseCase.execute(_GetSantriListObserver(this));
  }

  void doGetNilaiList() {
    getNilaiListState(RequestState.loading);
    _getNilaiListUseCase.execute(_GetNilaiListObserver(this));
  }

  @override
  void dispose() {
    _getSantriListUseCase.dispose();
    _getNilaiListUseCase.dispose();
  }
}

class _GetSantriListObserver extends Observer<UseCaseResponse<List<Santri>>> {
  final HomeRecordPresenter _presenter;

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

class _GetNilaiListObserver extends Observer<UseCaseResponse<List<Nilai>>> {
  final HomeRecordPresenter _presenter;

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