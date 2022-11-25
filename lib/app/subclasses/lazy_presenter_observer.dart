
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class LazyPresenterObserver extends Observer<UseCaseResponse<RequestStatus>> {
  final Function(RequestStatus) func;

  LazyPresenterObserver(this.func);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    print(e);
    func(RequestStatus.failed);
  }

  @override
  void onNext(UseCaseResponse<RequestStatus>? response) {
    func(response!.response);
  }
}