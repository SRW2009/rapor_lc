
import 'dart:io';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/domain/entities/nilai.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/excel/export_nilai.dart';
import 'package:rapor_lc/domain/usecases/excel/import_nilai.dart';
import 'package:rapor_lc/domain/usecases/nilai/get_nilai_list.dart';
import 'package:rapor_lc/domain/usecases/printing/print.dart';
import 'package:rapor_lc/domain/usecases/printing/print_dummy.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list.dart';

class AdminHomeDashboardPresenter extends Presenter {
  late Function(List<Santri>) getSantriList;
  late Function(RequestState) getSantriListState;
  late Function(List<Nilai>) getNilaiList;
  late Function(RequestState) getNilaiListState;
  late Function(String) printExceptionMessage;
  late Function(List<int>?) getExportNilai;

  final GetSantriListUseCase _getSantriListUseCase;
  final GetNilaiListUseCase _getNilaiListUseCase;
  final PrintUseCase _printUseCase;
  final PrintDummyUseCase _printDummyUseCase;
  final ImportNilaiUseCase _importNilaiUseCase;
  final ExportNilaiUseCase _exportNilaiUseCase;
  AdminHomeDashboardPresenter(santriRepo, nilaiRepo, printingRepo, excelRepo)
      : _getSantriListUseCase = GetSantriListUseCase(santriRepo),
        _getNilaiListUseCase = GetNilaiListUseCase(nilaiRepo),
        _printUseCase = PrintUseCase(printingRepo),
        _printDummyUseCase = PrintDummyUseCase(printingRepo),
        _importNilaiUseCase = ImportNilaiUseCase(excelRepo),
        _exportNilaiUseCase = ExportNilaiUseCase(excelRepo);

  void doGetSantriList() {
    getSantriListState(RequestState.loading);
    _getSantriListUseCase.execute(_GetSantriListObserver(this));
  }
  void doGetNilaiList() {
    getNilaiListState(RequestState.loading);
    _getNilaiListUseCase.execute(_GetNilaiListObserver(this));
  }
  void doPrint(List<Santri> santriList, List<Nilai> nilaiList, printSettings) =>
      _printUseCase.execute(_LogsObserver(this), PrintUseCaseParams(santriList, nilaiList, printSettings));
  void doPrintDummy() => _printDummyUseCase.execute(_PrintDummyObserver(this));
  void doImport(List<File> files) => _importNilaiUseCase.execute(_LogsObserver(this), files);
  void doExport() => _exportNilaiUseCase.execute(_ExportObserver(this));

  @override
  void dispose() {
    _getSantriListUseCase.dispose();
    _getNilaiListUseCase.dispose();
    _printUseCase.dispose();
    _printDummyUseCase.dispose();
    _importNilaiUseCase.dispose();
    _exportNilaiUseCase.dispose();
  }
}

class _GetSantriListObserver extends Observer<UseCaseResponse<List<Santri>>> {
  final AdminHomeDashboardPresenter _presenter;

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
  final AdminHomeDashboardPresenter _presenter;

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

class _LogsObserver extends Observer<String> {
  final AdminHomeDashboardPresenter presenter;

  _LogsObserver(this.presenter);

  @override
  void onComplete() {
    presenter.printExceptionMessage('::: OPERASI SELESAI :::');
  }

  @override
  void onError(e) {
    print(e);
    presenter.printExceptionMessage('Terjadi masalah. Operasi dibatalkan. Error message:\n');
    presenter.printExceptionMessage(e.toString()+'\n');
  }

  @override
  void onNext(String? response) {
    if (response!=null) presenter.printExceptionMessage(response+'\n');
  }
}

class _PrintDummyObserver extends Observer<UseCaseResponse<void>> {
  final AdminHomeDashboardPresenter presenter;

  _PrintDummyObserver(this.presenter);

  @override
  void onComplete() {
    // TODO: implement onComplete
  }

  @override
  void onError(e) {
    // TODO: implement onError
  }

  @override
  void onNext(UseCaseResponse<void>? response) {
    // TODO: implement onNext
  }
}

class _ExportObserver extends Observer<UseCaseResponse<List<int>?>> {
  AdminHomeDashboardPresenter _presenter;

  _ExportObserver(this._presenter);

  @override
  void onComplete() {
    // TODO: implement onComplete
  }

  @override
  void onError(e) {
    print(e);
  }

  @override
  void onNext(UseCaseResponse<List<int>?>? response) {
    _presenter.getExportNilai(response?.response);
  }
}