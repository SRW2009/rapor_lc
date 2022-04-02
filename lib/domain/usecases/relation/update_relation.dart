
import 'package:rapor_lc/common/enum.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/relation_repo.dart';

class UpdateRelationUseCase extends BaseUseCase<RequestStatus, Relation, RelationRepository> {
  RelationRepository repository;

  UpdateRelationUseCase(this.repository) : super(repository, (repo, param) => repo.updateRelation(param));
}