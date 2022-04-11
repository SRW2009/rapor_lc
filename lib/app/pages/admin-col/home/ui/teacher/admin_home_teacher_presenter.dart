
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/divisi/get_divisi_list.dart';
import 'package:rapor_lc/domain/usecases/teacher/create_teacher.dart';
import 'package:rapor_lc/domain/usecases/teacher/delete_teacher.dart';
import 'package:rapor_lc/domain/usecases/teacher/get_teacher_list.dart';
import 'package:rapor_lc/domain/usecases/teacher/update_teacher.dart';

class AdminHomeTeacherPresenter extends Presenter {
  late Function(List<Teacher>) getTeacherList;
  late Function(RequestState) getTeacherListState;
  late Function(RequestStatus) createTeacherStatus;
  late Function(RequestStatus) updateTeacherStatus;
  late Function(RequestStatus) deleteTeacherStatus;

  final GetTeacherListUseCase _getTeacherListAdminUseCase;
  final CreateTeacherUseCase _createTeacherUseCase;
  final UpdateTeacherUseCase _updateTeacherUseCase;
  final DeleteTeacherUseCase _deleteTeacherUseCase;
  final GetDivisiListUseCase _getDivisiListUseCase;
  AdminHomeTeacherPresenter(userRepo, divisiRepo)
      : _getTeacherListAdminUseCase = GetTeacherListUseCase(userRepo),
        _createTeacherUseCase = CreateTeacherUseCase(userRepo),
        _updateTeacherUseCase = UpdateTeacherUseCase(userRepo),
        _deleteTeacherUseCase = DeleteTeacherUseCase(userRepo),
        _getDivisiListUseCase = GetDivisiListUseCase(divisiRepo);

  void doGetTeacherList() {
    getTeacherListState(RequestState.loading);
    _getTeacherListAdminUseCase.execute(_GetTeacherListObserver(this), UseCaseParams<int?>(null));
  }
  void doCreateTeacher(Teacher teacher) {
    createTeacherStatus(RequestStatus.loading);
    _createTeacherUseCase.execute(_CreateTeacherObserver(this), UseCaseParams<Teacher>(teacher));
  }
  void doUpdateTeacher(Teacher teacher) {
    updateTeacherStatus(RequestStatus.loading);
    _updateTeacherUseCase.execute(_UpdateTeacherObserver(this), UseCaseParams<Teacher>(teacher));
  }
  void doDeleteTeacher(List<String> ids) {
    updateTeacherStatus(RequestStatus.loading);
    _deleteTeacherUseCase.execute(_DeleteTeacherObserver(this), UseCaseParams<List<String>>(ids));
  }
  Future<List<Divisi>> futureGetDivisiList() {
    return _getDivisiListUseCase.repository.getDivisiList();
  }

  @override
  void dispose() {
    _getTeacherListAdminUseCase.dispose();
    _createTeacherUseCase.dispose();
    _updateTeacherUseCase.dispose();
    _deleteTeacherUseCase.dispose();
    _getDivisiListUseCase.dispose();
  }
}

class _GetTeacherListObserver extends Observer<UseCaseResponse<List<Teacher>>> {
  final AdminHomeTeacherPresenter _presenter;

  _GetTeacherListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getTeacherListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<Teacher>>? response) {
    final list = response!.response;
    _presenter.getTeacherList(list);
    _presenter.getTeacherListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}

class _CreateTeacherObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeTeacherPresenter _presenter;

  _CreateTeacherObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.createTeacherStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.createTeacherStatus(response!.response);
}

class _UpdateTeacherObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeTeacherPresenter _presenter;

  _UpdateTeacherObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.updateTeacherStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.updateTeacherStatus(response!.response);
}

class _DeleteTeacherObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeTeacherPresenter _presenter;

  _DeleteTeacherObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.deleteTeacherStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.deleteTeacherStatus(response!.response);
}