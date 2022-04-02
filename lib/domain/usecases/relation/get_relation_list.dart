
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';
import 'package:rapor_lc/domain/repositories/relation_repo.dart';

class GetRelationListUseCase extends BaseUseCase<List<Relation>, void, RelationRepository> {
  RelationRepository repository;

  GetRelationListUseCase(this.repository) : super(repository, (repo, param) => repo.getRelationList());
}