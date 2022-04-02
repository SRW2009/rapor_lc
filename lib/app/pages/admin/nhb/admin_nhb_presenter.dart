
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/mapel/get_mapel_list.dart';
import 'package:rapor_lc/domain/usecases/nilai/update_nilai.dart';

class AdminNHBPresenter extends Presenter {
  late Function(RequestStatus) updateNilaiStatus;

  final UpdateNilaiUseCase _updateNilaiUseCase;
  final GetMataPelajaranListUseCase _getMataPelajaranListUseCase;
  AdminNHBPresenter(nilaiRepo, mapelRepo) :
        _updateNilaiUseCase = UpdateNilaiUseCase(nilaiRepo),
        _getMataPelajaranListUseCase = GetMataPelajaranListUseCase(mapelRepo);

  void doUpdateNilai(Nilai nilai) {
    updateNilaiStatus(RequestStatus.loading);
    _updateNilaiUseCase.execute(_UpdateNilaiObserver(this), UseCaseParams<Nilai>(nilai));
  }
  Future<List<MataPelajaran>> futureGetMapelList() {
    return _getMataPelajaranListUseCase.repository.getMataPelajaranList();
  }

  @override
  void dispose() {
    _updateNilaiUseCase.dispose();
    _getMataPelajaranListUseCase.dispose();
  }
}

class _UpdateNilaiObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminNHBPresenter _presenter;

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