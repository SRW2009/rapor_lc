
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/repositories/relation_repo.dart';
import 'package:rapor_lc/domain/usecases/base_use_case.dart';

class DeleteRelationUseCase extends BaseUseCase<RequestStatus, List<String>, RelationRepository> {
  final RelationRepository repository;

  DeleteRelationUseCase(this.repository) : super(repository, (repo, param) => repo.deleteRelation(param));
}