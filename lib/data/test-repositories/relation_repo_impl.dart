
import 'package:rapor_lc/common/enum.dart';
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
        relationList.add(relation);
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<RequestStatus> deleteRelation(List<String> ids) async =>
      Future.delayed(DataConstant.test_duration, () async {
        relationList.removeWhere((element) => ids.contains(element.id.toString()));
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });

  @override
  Future<List<Relation>> getRelationList() async =>
      Future.delayed(DataConstant.test_duration, () async {
        return relationList;
        //failed
        throw Exception();
      });

  @override
  Future<RequestStatus> updateRelation(Relation relation) async =>
      Future.delayed(DataConstant.test_duration, () async {
        final index = relationList.indexOf(relation);
        relationList.replaceRange(
          index, index+1, [relation]
        );
        return RequestStatus.success;
        //failed
        return RequestStatus.failed;
      });
}