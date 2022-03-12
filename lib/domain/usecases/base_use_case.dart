
import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rapor_lc/common/repository.dart';

class BaseUseCase<Res, Par, Rep extends Repository>
    extends UseCase<UseCaseResponse<Res>, UseCaseParams<Par>> {
  final Rep repo;
  final Future<Res> Function(Rep repo, Par param) whichFunction;
  final UseCaseResponse<Res> res;

  BaseUseCase(this.repo, this.whichFunction) : res = UseCaseResponse<Res>();

  @override
  Future<Stream<UseCaseResponse<Res>?>> buildUseCaseStream(UseCaseParams? params) async {
    final controller = StreamController<UseCaseResponse<Res>>();
    try {
      final response = await whichFunction(repo, params?.params);
      res.response = response;
      controller.add(res);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

class UseCaseResponse<T> {
  late T response;
}

class UseCaseParams<T> {
  final T params;

  UseCaseParams(this.params);
}