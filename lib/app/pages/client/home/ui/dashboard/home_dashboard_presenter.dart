
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/nhb/get_nhb_list_admin.dart';
import 'package:rapor_lc/domain/usecases/nk/get_nk_list_admin.dart';
import 'package:rapor_lc/domain/usecases/npb/get_npb_list_admin.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list_admin.dart';

class HomeDashboardPresenter extends Presenter {
  late Function(List<Santri>) getSantriListOnNext;
  late Function(dynamic) getSantriListOnError;
  late Function(List<NHB>) getNHBListOnNext;
  late Function(dynamic) getNHBListOnError;
  late Function(List<NK>) getNKListOnNext;
  late Function(dynamic) getNKListOnError;
  late Function(List<NPB>) getNPBListOnNext;
  late Function(dynamic) getNPBListOnError;

  GetSantriListAdminUseCase _getSantriListAdminUseCase;
  GetNHBListAdminUseCase _getNHBListAdminUseCase;
  GetNKListAdminUseCase _getNKListAdminUseCase;
  GetNPBListAdminUseCase _getNPBListAdminUseCase;
  HomeDashboardPresenter(santriRepository, nhbRepository, nkRepository, npbRepository)
      : _getSantriListAdminUseCase = GetSantriListAdminUseCase(santriRepository),
        _getNHBListAdminUseCase = GetNHBListAdminUseCase(nhbRepository),
        _getNKListAdminUseCase = GetNKListAdminUseCase(nkRepository),
        _getNPBListAdminUseCase = GetNPBListAdminUseCase(npbRepository);

  void doGetSantriList() => _getSantriListAdminUseCase.execute(_GetSantriListObserver(this));
  void doGetNHBList() => _getNHBListAdminUseCase.execute(_GetNHBListObserver(this));
  void doGetNKList() => _getNKListAdminUseCase.execute(_GetNKListObserver(this));
  void doGetNPBList() => _getNPBListAdminUseCase.execute(_GetNPBListObserver(this));

  @override
  void dispose() {
    _getSantriListAdminUseCase.dispose();
    _getNHBListAdminUseCase.dispose();
    _getNKListAdminUseCase.dispose();
    _getNPBListAdminUseCase.dispose();
  }
}

class _GetSantriListObserver extends Observer<UseCaseResponse<List<Santri>>> {
  final HomeDashboardPresenter presenter;

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

class _GetNHBListObserver extends Observer<UseCaseResponse<List<NHB>>> {
  final HomeDashboardPresenter presenter;

  _GetNHBListObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.getNHBListOnError(e);
  }

  @override
  void onNext(UseCaseResponse<List<NHB>>? response) {
    presenter.getNHBListOnNext(response!.response);
  }
}

class _GetNKListObserver extends Observer<UseCaseResponse<List<NK>>> {
  final HomeDashboardPresenter presenter;

  _GetNKListObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.getNKListOnError(e);
  }

  @override
  void onNext(UseCaseResponse<List<NK>>? response) {
    presenter.getNKListOnNext(response!.response);
  }
}

class _GetNPBListObserver extends Observer<UseCaseResponse<List<NPB>>> {
  final HomeDashboardPresenter presenter;

  _GetNPBListObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    presenter.getNPBListOnError(e);
  }

  @override
  void onNext(UseCaseResponse<List<NPB>>? response) {
    presenter.getNPBListOnNext(response!.response);
  }
}