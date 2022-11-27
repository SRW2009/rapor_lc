
import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/repositories/relation_repo.dart';
import 'package:rapor_lc/dummy_data/dummies.dart' as d;

class RelationRepositoryImplTest extends RelationRepository {
  final List<Relation> relationList;

  // singleton
  RelationRepositoryImplTest._internal()
      : relationList = [...d.relationList];
  static final RelationRepositoryImplTest _instance = RelationRepositoryImplTest._internal();
  factory RelationRepositoryImplTest() => _instance;

  @override
  Future<RequestStatus> createRelation(Relation relation) =>
      Future.delayed(DataConstant.test_duration, () async {
        final item = Relation.fromJson(relation.toJson()..['id']=relationList.length);
        relationList.add(item);
        return RequestStatus.success;
      });

  @override
  Future<RequestStatus> deleteRelation(List<String> ids) async =>
      Future.delayed(DataConstant.test_duration, () async {
        relationList.removeWhere((element) => ids.contains(element.id.toString()));
        return RequestStatus.success;
      });

  @override
  Future<List<Relation>> getRelationList() async =>
      Future.delayed(DataConstant.test_duration, () async {
        return relationList;
      });

  @override
  Future<RequestStatus> updateRelation(Relation relation) async =>
      Future.delayed(DataConstant.test_duration, () async {
        final index = relationList.indexOf(relation);
        relationList.replaceRange(
          index, index+1, [relation]
        );
        return RequestStatus.success;
      });

  @override
  String url = '';
}