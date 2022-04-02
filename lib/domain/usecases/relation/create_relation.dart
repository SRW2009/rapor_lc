

import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/repositories/relation_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class CreateRelationUseCase extends BaseUseCase<RequestStatus, Relation, RelationRepository> {
  final RelationRepository repository;

  CreateRelationUseCase(this.repository) : super(repository, (repo, param) => repo.createRelation(param));
}