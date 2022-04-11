
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list.dart';

class HomeDashboardPresenter extends Presenter {
  late Function(List<Santri>) getSantriListOnNext;
  late Function(dynamic) getSantriListOnError;

  final GetSantriListUseCase _getSantriListUseCase;
  HomeDashboardPresenter(santriRepository)
      : _getSantriListUseCase = GetSantriListUseCase(santriRepository);

  void doGetSantriList() => _getSantriListUseCase.execute(_GetSantriListObserver(this));

  @override
  void dispose() {
    _getSantriListUseCase.dispose();
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
