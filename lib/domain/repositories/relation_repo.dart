
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/common/repository.dart';

abstract class RelationRepository extends Repository {
  Future<List<Relation>> getRelationList();
  Future<RequestStatus> createRelation(Relation relation);
  Future<RequestStatus> updateRelation(Relation relation);
  Future<RequestStatus> deleteRelation(List<String> ids);
}