
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/app/utils/request_state.dart';
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/entities/teacher.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/relation/create_relation.dart';
import 'package:rapor_lc/domain/usecases/relation/delete_relation.dart';
import 'package:rapor_lc/domain/usecases/relation/get_relation_list.dart';
import 'package:rapor_lc/domain/usecases/relation/update_relation.dart';
import 'package:rapor_lc/domain/usecases/santri/get_santri_list.dart';
import 'package:rapor_lc/domain/usecases/teacher/get_teacher_list.dart';

class AdminHomeRelationPresenter extends Presenter {
  late Function(List<Relation>) getRelationList;
  late Function(RequestState) getRelationListState;
  late Function(RequestStatus) createRelationStatus;
  late Function(RequestStatus) updateRelationStatus;
  late Function(RequestStatus) deleteRelationStatus;

  final GetRelationListUseCase _getRelationListAdminUseCase;
  final CreateRelationUseCase _createRelationUseCase;
  final UpdateRelationUseCase _updateRelationUseCase;
  final DeleteRelationUseCase _deleteRelationUseCase;
  final GetTeacherListUseCase _getTeacherListUseCase;
  final GetSantriListUseCase _getSantriListUseCase;
  AdminHomeRelationPresenter(relationRepo, teacherRepo, santriRepo)
      : _getRelationListAdminUseCase = GetRelationListUseCase(relationRepo),
        _createRelationUseCase = CreateRelationUseCase(relationRepo),
        _updateRelationUseCase = UpdateRelationUseCase(relationRepo),
        _deleteRelationUseCase = DeleteRelationUseCase(relationRepo),
        _getTeacherListUseCase = GetTeacherListUseCase(teacherRepo),
        _getSantriListUseCase = GetSantriListUseCase(santriRepo);

  void doGetRelationList() {
    getRelationListState(RequestState.loading);
    _getRelationListAdminUseCase.execute(_GetRelationListObserver(this), UseCaseParams<int?>(null));
  }
  void doCreateRelation(Relation santri) {
    createRelationStatus(RequestStatus.loading);
    _createRelationUseCase.execute(_CreateRelationObserver(this), UseCaseParams<Relation>(santri));
  }
  void doUpdateRelation(Relation santri) {
    updateRelationStatus(RequestStatus.loading);
    _updateRelationUseCase.execute(_UpdateRelationObserver(this), UseCaseParams<Relation>(santri));
  }
  void doDeleteRelation(List<String> ids) {
    updateRelationStatus(RequestStatus.loading);
    _deleteRelationUseCase.execute(_DeleteRelationObserver(this), UseCaseParams<List<String>>(ids));
  }
  Future<List<Teacher>> futureGetTeacherList() {
    return _getTeacherListUseCase.repository.getTeacherList();
  }
  Future<List<Santri>> futureGetSantriList() {
    return _getSantriListUseCase.repository.getSantriList();
  }

  @override
  void dispose() {
    _getRelationListAdminUseCase.dispose();
    _createRelationUseCase.dispose();
    _updateRelationUseCase.dispose();
    _deleteRelationUseCase.dispose();
    _getTeacherListUseCase.dispose();
    _getSantriListUseCase.dispose();
  }
}

class _GetRelationListObserver extends Observer<UseCaseResponse<List<Relation>>> {
  final AdminHomeRelationPresenter _presenter;

  _GetRelationListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.getRelationListState(RequestState.error);
  }

  @override
  void onNext(UseCaseResponse<List<Relation>>? response) {
    final list = response!.response;
    _presenter.getRelationList(list);
    _presenter.getRelationListState(list.isNotEmpty ? RequestState.loaded : RequestState.none);
  }
}

class _CreateRelationObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeRelationPresenter _presenter;

  _CreateRelationObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.createRelationStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.createRelationStatus(response!.response);
}

class _UpdateRelationObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeRelationPresenter _presenter;

  _UpdateRelationObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.updateRelationStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.updateRelationStatus(response!.response);
}

class _DeleteRelationObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final AdminHomeRelationPresenter _presenter;

  _DeleteRelationObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    _presenter.deleteRelationStatus(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) =>
      _presenter.deleteRelationStatus(response!.response);
}