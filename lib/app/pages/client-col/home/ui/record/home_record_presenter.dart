
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/common/enum/request_state.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/usecases/relation/get_relation_list.dart';

class HomeRecordPresenter extends Presenter {
  late Function(List<Relation>) getRelationList;
  late Function(RequestState) getRelationListState;

  final GetRelationListUseCase _getRelationListUseCase;
  HomeRecordPresenter(relationRepo)
      : _getRelationListUseCase = GetRelationListUseCase(relationRepo);

  void doGetRelationList() {
    getRelationListState(RequestState.loading);
    _getRelationListUseCase.execute(_GetRelationListObserver(this));
  }

  @override
  void dispose() {
    _getRelationListUseCase.dispose();
  }
}

class _GetRelationListObserver extends Observer<UseCaseResponse<List<Relation>>> {
  final HomeRecordPresenter _presenter;

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