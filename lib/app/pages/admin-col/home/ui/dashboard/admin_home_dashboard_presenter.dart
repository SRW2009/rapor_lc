
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/nilai/get_nilai_list.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list.dart';

class AdminHomeDashboardPresenter extends Presenter {
  late Function(List<Santri>) getSantriListOnNext;
  late Function(dynamic) getSantriListOnError;
  late Function(List<Nilai>) getNilaiListOnNext;
  late Function(dynamic) getNilaiListOnError;

  final GetSantriListUseCase _getSantriListUseCase;
  final GetNilaiListUseCase _getNilaiListUseCase;
  AdminHomeDashboardPresenter(santriRepo, nilaiRepo)
      : _getSantriListUseCase = GetSantriListUseCase(santriRepo),
        _getNilaiListUseCase = GetNilaiListUseCase(nilaiRepo);

  void doGetSantriList() => _getSantriListUseCase.execute(_GetSantriListObserver(this));
  void doGetNilaiList() => _getNilaiListUseCase.execute(_GetNilaiListObserver(this));

  @override
  void dispose() {
    _getSantriListUseCase.dispose();
    _getNilaiListUseCase.dispose();
  }
}

class _GetSantriListObserver extends Observer<UseCaseResponse<List<Santri>>> {
  final AdminHomeDashboardPresenter presenter;

  _GetSantriListObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.getSantriListOnError(e);
  }

  @override
  void onNext(UseCaseResponse<List<Santri>>? response) {
    presenter.getSantriListOnNext(response!.response);
  }
}

class _GetNilaiListObserver extends Observer<UseCaseResponse<List<Nilai>>> {
  final AdminHomeDashboardPresenter presenter;

  _GetNilaiListObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.getNilaiListOnError(e);
  }

  @override
  void onNext(UseCaseResponse<List<Nilai>>? response) {
    presenter.getNilaiListOnNext(response!.response);
  }
}